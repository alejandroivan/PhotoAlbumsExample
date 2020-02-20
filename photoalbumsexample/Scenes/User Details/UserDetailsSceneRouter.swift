//
//  UserDetailsSceneRouter.swift
//  photoalbumsexample
//
//  Created by Alejandro Melo Domínguez on 19-02-20.
//  Copyright (c) 2020 Alejandro Melo Domínguez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserDetailsSceneRoutingLogic {
    func routeToUserAlbums(user: User?)
}

protocol UserDetailsSceneDataPassing {
    var dataStore: UserDetailsSceneDataStore? { get }
}

class UserDetailsSceneRouter: NSObject, UserDetailsSceneRoutingLogic, UserDetailsSceneDataPassing {
    weak var viewController: UserDetailsSceneViewController?
    var dataStore: UserDetailsSceneDataStore?

    // MARK: Routing
    func routeToUserAlbums(user: User?) {
        guard let user = user else { return }
        let destinationVC = UserAlbumsSceneViewController()
        var destinationDS = destinationVC.router!.dataStore!

        passDataToUserAlbums(user: user, destination: &destinationDS)
        navigateToUserAlbums(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToUserAlbums(source: UserDetailsSceneViewController, destination: UserAlbumsSceneViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToUserAlbums(user: User, destination: inout UserAlbumsSceneDataStore) {
        destination.userId = user.id
    }
}
