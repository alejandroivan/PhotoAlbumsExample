import UIKit

class UserAlbumsSceneTableViewDelegate: NSObject {
    weak var viewController: (UserAlbumsSceneTableViewLogic & UserAlbumsSceneDisplayLogic)?

    init(viewController: (UserAlbumsSceneTableViewLogic & UserAlbumsSceneDisplayLogic)?) {
        self.viewController = viewController
    }
}

extension UserAlbumsSceneTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
