import Foundation
@testable import photoalbumsexample

class UsersScenePresentationLogicSpy: UsersScenePresentationLogic {
    var presentUsersListCalled = false
    var presentErrorMessageCalled = false

    func presentUsersList(response: UsersScene.FetchAll.Response) {
        presentUsersListCalled = true
    }

    func presentErrorMessage() {
        presentErrorMessageCalled = true
    }
}
