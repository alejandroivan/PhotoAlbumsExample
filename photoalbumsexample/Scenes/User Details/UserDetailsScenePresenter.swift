//
//  UserDetailsScenePresenter.swift
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

protocol UserDetailsScenePresentationLogic {
    func presentUpdatedData(response: UserDetailsScene.UpdatedData.Response)
}

class UserDetailsScenePresenter: UserDetailsScenePresentationLogic {
    weak var viewController: UserDetailsSceneDisplayLogic?

    // MARK: Do something

    func presentUpdatedData(response: UserDetailsScene.UpdatedData.Response) {
        let viewModel = UserDetailsScene.UpdatedData.ViewModel(
            screenTitle: response.screenTitle,
            name: response.name,
            phone: response.phone
        )
        viewController?.refreshScreen(viewModel: viewModel)
    }
}
