//
//  UserAlbumsScenePresenter.swift
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

protocol UserAlbumsScenePresentationLogic {
    func presentSomething(response: UserAlbumsScene.Something.Response)
}

class UserAlbumsScenePresenter: UserAlbumsScenePresentationLogic {
    weak var viewController: UserAlbumsSceneDisplayLogic?

    // MARK: Do something

    func presentSomething(response: UserAlbumsScene.Something.Response) {
        let viewModel = UserAlbumsScene.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
