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
    func routeToAlbum(with id: Int)
}

protocol UserAlbumsSceneDataPassing {
    var dataStore: UserAlbumsSceneDataStore? { get }
}

class UserAlbumsSceneRouter: NSObject, UserAlbumsSceneRoutingLogic, UserAlbumsSceneDataPassing {
    weak var viewController: UserAlbumsSceneViewController?
    var dataStore: UserAlbumsSceneDataStore?

    // MARK: Routing

    func routeToAlbum(with id: Int) {
        print("Routing to album with ID: \(id)")
    }

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: UserAlbumsSceneViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: UserAlbumsSceneDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
