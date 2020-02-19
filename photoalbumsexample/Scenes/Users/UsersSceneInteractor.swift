import UIKit

protocol UsersSceneBusinessLogic {
    func fetchAllUsers(request: UsersScene.FetchAll.Request)
}

protocol UsersSceneDataStore {
    //var name: String { get set }
}

class UsersSceneInteractor: UsersSceneBusinessLogic, UsersSceneDataStore {
    var presenter: UsersScenePresentationLogic?
    var worker: UsersSceneWorker? = UsersSceneWorker()
    //var name: String = ""

    // MARK: Do something

    func fetchAllUsers(request: UsersScene.FetchAll.Request) {
        worker?.fetchAllUsers(completion: { (success, users) in
            if success {
                let response = UsersScene.FetchAll.Response(users: users)
                self.presenter?.presentUsersList(response: response)
            }
        })
    }
}
