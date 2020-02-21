//
//  AppNavigationController.swift
//  photoalbumsexample
//
//  Created by Alejandro Melo Domínguez on 19-02-20.
//  Copyright © 2020 Alejandro Melo Domínguez. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var interfaceOrientation: UIInterfaceOrientation {
        return .portrait
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        setupInitialViewController()
    }

    func setupTheme() {
        navigationBar.barStyle = .black
        navigationBar.barTintColor = Colors.NavigationBar.background
        navigationBar.tintColor = Colors.NavigationBar.text
        navigationBar.isTranslucent = false
    }
    
    func setupInitialViewController() {
        let viewController = UsersSceneViewController()
        setViewControllers([viewController], animated: false)
    }
}
