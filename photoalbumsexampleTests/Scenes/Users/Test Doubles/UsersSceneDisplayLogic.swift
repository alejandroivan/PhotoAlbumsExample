import Foundation
@testable import photoalbumsexample

class UsersSceneDisplayLogicSpy: UsersSceneDisplayLogic {
    var isLoading: Bool = false // Required for protocol

    var showUsersCalled = false
    var showErrorCalled = false


    func showUsers(viewModel: UsersScene.FetchAll.ViewModel) {
        showUsersCalled = true
    }

    func showError() {
        showErrorCalled = true
    }

}
