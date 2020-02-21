import UIKit

protocol UsersSceneBusinessLogic {
    func fetchAllUsers(request: UsersScene.FetchAll.Request)
}

protocol UsersSceneDataStore {
    var users: Users? { get }
}

class UsersSceneInteractor: UsersSceneBusinessLogic, UsersSceneDataStore {
    var presenter: UsersScenePresentationLogic?
    var worker: UsersSceneWorker? = UsersSceneWorker()
    var users: Users?

    // MARK: Do something

    func fetchAllUsers(request: UsersScene.FetchAll.Request) {
        worker?.fetchAllUsers(completion: { (success, users) in
            if success {
                self.users = users
                let response = UsersScene.FetchAll.Response()
                self.presenter?.presentUsersList(response: response)
            } else {
                self.presenter?.presentErrorMessage()
            }
        })
    }
}
