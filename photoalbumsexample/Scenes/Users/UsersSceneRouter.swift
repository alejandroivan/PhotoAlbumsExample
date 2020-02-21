import UIKit

protocol UsersSceneRoutingLogic {
    func routeToUserDetails(for index: Int)
}

protocol UsersSceneDataPassing {
    var dataStore: UsersSceneDataStore? { get }
}

class UsersSceneRouter: NSObject, UsersSceneRoutingLogic, UsersSceneDataPassing {
    weak var viewController: UsersSceneViewController?
    var dataStore: UsersSceneDataStore?

    // MARK: Routing

    func routeToUserDetails(for index: Int) {
        let destinationVC = UserDetailsSceneViewController()
        var destinationDS = destinationVC.router!.dataStore!

        passDataToUserDetails(source: dataStore!, destination: &destinationDS, userIndex: index)
        navigateToUserDetails(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToUserDetails(source: UsersSceneViewController, destination: UserDetailsSceneViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToUserDetails(source: UsersSceneDataStore, destination: inout UserDetailsSceneDataStore, userIndex: Int) {
        guard let user = source.users?[userIndex] else { return }
        destination.user = user
    }
}
