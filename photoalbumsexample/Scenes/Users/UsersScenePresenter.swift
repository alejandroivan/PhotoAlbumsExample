import UIKit

protocol UsersScenePresentationLogic {
    func presentUsersList(response: UsersScene.FetchAll.Response)
    func presentErrorMessage()
}

class UsersScenePresenter: UsersScenePresentationLogic {
    weak var viewController: UsersSceneDisplayLogic?

    // MARK: Do something

    func presentUsersList(response: UsersScene.FetchAll.Response) {
        let viewModel = UsersScene.FetchAll.ViewModel(users: response.users)
        viewController?.showUsers(viewModel: viewModel)
    }

    func presentErrorMessage() {
        viewController?.showError()
    }
}
