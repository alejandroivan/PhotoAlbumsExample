import UIKit

protocol UsersSceneDisplayLogic: class {
    func showUsers(viewModel: UsersScene.FetchAll.ViewModel)
}

class UsersSceneViewController: UIViewController, UsersSceneDisplayLogic {
    var interactor: UsersSceneBusinessLogic?
    var router: (NSObjectProtocol & UsersSceneRoutingLogic & UsersSceneDataPassing)?

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
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Usuarios"
        view.backgroundColor = Colors.ViewController.background
        fetchAllUsers()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func fetchAllUsers() {
        let request = UsersScene.FetchAll.Request()
        interactor?.fetchAllUsers(request: request)
    }

    func showUsers(viewModel: UsersScene.FetchAll.ViewModel) {

    }
}
