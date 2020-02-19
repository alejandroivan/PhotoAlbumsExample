import UIKit

class UsersSceneTableViewDelegate: NSObject {
    weak var viewController: UsersSceneViewController?

    init(viewController: UsersSceneViewController?) {
        
    }
}

extension UsersSceneTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Needed for iOS 10- only
    }
}
