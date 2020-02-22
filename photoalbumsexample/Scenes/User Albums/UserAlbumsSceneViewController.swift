//
//  UserAlbumsSceneViewController.swift
//  photoalbumsexample
//
//  Created by Alejandro Melo Domínguez on 20-02-20.
//  Copyright (c) 2020 Alejandro Melo Domínguez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserAlbumsSceneDisplayLogic: class {
    func displayAlbums(viewModel: UserAlbumsScene.LoadAlbums.ViewModel)
    func displayError()
}

protocol UserAlbumsSceneTableViewLogic: class {}

class UserAlbumsSceneViewController: UIViewController, UserAlbumsSceneDisplayLogic, UserAlbumsSceneTableViewLogic {
    var interactor: UserAlbumsSceneBusinessLogic?
    var router: (NSObjectProtocol & UserAlbumsSceneRoutingLogic & UserAlbumsSceneDataPassing)?

    var tableView = UITableView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)

    var tableViewDataSource: UserAlbumsSceneTableViewDataSource? {
        didSet {
            tableView.dataSource = tableViewDataSource
        }
    }

    var tableViewDelegate: UserAlbumsSceneTableViewDelegate? {
        didSet {
            tableView.delegate = tableViewDelegate
        }
    }

    var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
//                self.refreshControl?.endRefreshing()
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
        let interactor = UserAlbumsSceneInteractor()
        let presenter = UserAlbumsScenePresenter()
        let router = UserAlbumsSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
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

    func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bounces = false
        tableView.separatorColor = Colors.Separators.background
        tableView.tableFooterView = UIView() // Avoids drawing more cells than available

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: getTopAnchor()),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

        tableViewDataSource = UserAlbumsSceneTableViewDataSource(viewController: self)
        tableViewDelegate = UserAlbumsSceneTableViewDelegate(viewController: self)
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: "UsersTableViewCell")
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        title = "Álbumes"
        view.backgroundColor = Colors.ViewController.background

        loadAlbums()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }

    // MARK: Do something

    func loadAlbums() {
        isLoading = true
        let request = UserAlbumsScene.LoadAlbums.Request()
        interactor?.loadAlbums(request: request)
    }

    func displayAlbums(viewModel: UserAlbumsScene.LoadAlbums.ViewModel) {
        isLoading = false
        print("ALBUMS: \(viewModel.albums)")
    }

    func displayError() {
        isLoading = false
        print("ERROR!")
    }
}
