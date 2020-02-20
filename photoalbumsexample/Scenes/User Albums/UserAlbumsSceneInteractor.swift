//
//  UserAlbumsSceneInteractor.swift
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

protocol UserAlbumsSceneBusinessLogic {
    func doSomething(request: UserAlbumsScene.Something.Request)
}

protocol UserAlbumsSceneDataStore {
    var userId: Int { get set }
}

class UserAlbumsSceneInteractor: UserAlbumsSceneBusinessLogic, UserAlbumsSceneDataStore {
    var presenter: UserAlbumsScenePresentationLogic?
    var worker: UserAlbumsSceneWorker?
    var userId: Int = 0

    // MARK: Do something

    func doSomething(request: UserAlbumsScene.Something.Request) {
        worker = UserAlbumsSceneWorker()
        worker?.doSomeWork()

        let response = UserAlbumsScene.Something.Response()
        presenter?.presentSomething(response: response)
    }
}