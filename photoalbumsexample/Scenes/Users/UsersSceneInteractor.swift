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
        guard !request.favoritesOnly else {
            filterFavorites(request: request)
            return
        }

        worker?.fetchAllUsers(completion: { (success, users) in
            if success {
                self.users = users
                let response = UsersScene.FetchAll.Response(favoritesOnly: false, users: users)
                self.presenter?.presentUsersList(response: response)
            } else {
                self.presenter?.presentErrorMessage()
            }
        })
    }

    func filterFavorites(request: UsersScene.FetchAll.Request) {
        guard let users = users, !users.isEmpty else { return }
        let favoriteUsers = users.filter { $0.isFavorite }
        let response = UsersScene.FetchAll.Response(favoritesOnly: true, users: favoriteUsers)
        presenter?.presentUsersList(response: response)
    }
}
