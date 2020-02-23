//
//  UserAlbumsSceneRouter.swift
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

@objc protocol UserAlbumsSceneRoutingLogic {
    func routeToAlbum()
}

protocol UserAlbumsSceneDataPassing {
    var dataStore: UserAlbumsSceneDataStore? { get }
}

class UserAlbumsSceneRouter: NSObject, UserAlbumsSceneRoutingLogic, UserAlbumsSceneDataPassing {
    weak var viewController: UserAlbumsSceneViewController?
    var dataStore: UserAlbumsSceneDataStore?

    // MARK: Routing

    func routeToAlbum() {
        let destinationVC = AlbumDetailsViewController()
        var destinationDS = destinationVC.router!.dataStore!

        passDataToAlbumDetails(source: dataStore!, destination: &destinationDS)
        navigateToAlbumDetails(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToAlbumDetails(source: UserAlbumsSceneViewController, destination: AlbumDetailsViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToAlbumDetails(source: UserAlbumsSceneDataStore, destination: inout AlbumDetailsDataStore) {
        destination.albumId = source.selectedAlbumId
        destination.albumTitle = source.selectedAlbumTitle
    }
}
