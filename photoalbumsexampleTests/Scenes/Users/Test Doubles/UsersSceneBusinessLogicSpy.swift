import Foundation
@testable import photoalbumsexample

class UsersSceneBusinessLogicSpy: UsersSceneBusinessLogic {
    var fetchAllUsersCalled = false

    func fetchAllUsers(request: UsersScene.FetchAll.Request) {
        fetchAllUsersCalled = true
    }
}
