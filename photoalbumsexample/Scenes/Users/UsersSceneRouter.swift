import UIKit

protocol UsersSceneRoutingLogic {
    func routeToUserDetails(_ user: User)
}

protocol UsersSceneDataPassing {
    var dataStore: UsersSceneDataStore? { get }
}

class UsersSceneRouter: NSObject, UsersSceneRoutingLogic, UsersSceneDataPassing {
    weak var viewController: UsersSceneViewController?
    var dataStore: UsersSceneDataStore?

    // MARK: Routing

    func routeToUserDetails(_ user: User) {
        let destinationVC = UserDetailsSceneViewController()
        var destinationDS = destinationVC.router!.dataStore!

        passDataToUserDetails(user: user, destination: &destinationDS)
        navigateToUserDetails(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToUserDetails(source: UsersSceneViewController, destination: UserDetailsSceneViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToUserDetails(user: User, destination: inout UserDetailsSceneDataStore) {
        destination.user = user
    }
}
