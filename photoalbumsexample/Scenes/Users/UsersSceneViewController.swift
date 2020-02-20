import UIKit

protocol UsersSceneDisplayLogic: class {
    var isLoading: Bool { get set }
    func showUsers(viewModel: UsersScene.FetchAll.ViewModel)
    func showError()
}

protocol UsersSceneTableViewLogic: class {
    var users: Users? { get }
    var tableView: UITableView { get }

    func didSelectCellAtIndex(_ index: Int)
}

class UsersSceneViewController: UIViewController, UsersSceneDisplayLogic, UsersSceneTableViewLogic {
    var interactor: UsersSceneBusinessLogic?
    var router: (NSObjectProtocol & UsersSceneRoutingLogic & UsersSceneDataPassing)?

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
    var tableView: UITableView = UITableView()
    weak var refreshControl: UIRefreshControl?
    weak var errorView: ErrorView?

    var tableViewDataSource: UITableViewDataSource? {
        didSet {
            tableView.dataSource = tableViewDataSource
        }
    }

    var tableViewDelegate: UITableViewDelegate? {
        didSet {
            tableView.delegate = tableViewDelegate
        }
    }

    var users: Users?

    var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = UsersSceneInteractor()
        let presenter = UsersScenePresenter()
        let router = UsersSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        setupTableView()
        setupActivityIndicator()
        setupPullToRefresh()
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView() // Avoids drawing more cells than available

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: getTopAnchor()),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableViewDataSource = UsersSceneTableViewDataSource(viewController: self)
        tableViewDelegate = UsersSceneTableViewDelegate(viewController: self)

        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: "UsersTableViewCell")
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = Colors.ActivityIndicator.background
        activityIndicator.clipsToBounds = true
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.hidesWhenStopped = true

        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func setupPullToRefresh() {
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        refreshControl.backgroundColor = Colors.PullToRefresh.background
        refreshControl.tintColor = Colors.PullToRefresh.indicator

        refreshControl.addTarget(
            self,
            action: #selector(fetchAllUsers),
            for: .valueChanged
        )

        tableView.refreshControl = refreshControl
    }

    private func getTopAnchor() -> NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return topLayoutGuide.bottomAnchor
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Usuarios"
        view.backgroundColor = Colors.ViewController.background
        fetchAllUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    @objc
    func fetchAllUsers() {
        isLoading = true

        errorView?.removeFromSuperview()
        tableView.tableHeaderView = nil

        let request = UsersScene.FetchAll.Request()
        interactor?.fetchAllUsers(request: request)
    }

    func showUsers(viewModel: UsersScene.FetchAll.ViewModel) {
        users = viewModel.users
        isLoading = false
        self.tableView.reloadData()
    }

    // MARK: Table view logic
    func didSelectCellAtIndex(_ index: Int) {
        if let user = users?[index] {
            router?.routeToUserDetails(user)
        }
    }
}

extension UsersSceneViewController: ErrorViewDelegate {
    func showError() {
        guard errorView == nil else { return }

        let errorView = ErrorView(delegate: self)
        self.errorView = errorView
        view.addSubview(errorView)
        view.bringSubviewToFront(errorView)

        let heightConstraint = NSLayoutConstraint(
            item: errorView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 0
        )

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: getTopAnchor()),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightConstraint
        ])

        isLoading = false

        UIView.animate(withDuration: 0.3, animations: {
            heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }) { _ in
            // Create a header view with the same height as the error view, so content doesn't overlap
            self.tableView.tableHeaderView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 0,
                    height: 50
                )
            )
        }
    }

    func didTouchErrorView() {
        fetchAllUsers()
    }
}
