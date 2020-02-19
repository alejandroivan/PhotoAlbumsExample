import UIKit

class UsersSceneTableViewDelegate: NSObject {
    weak var viewController: UsersSceneTableViewLogic?

    init(viewController: UsersSceneTableViewLogic?) {
        self.viewController = viewController
    }
}

extension UsersSceneTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Needed for iOS 10- only
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewController?.didSelectCellAtIndex(index)
    }
}
