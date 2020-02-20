import UIKit

class UserDetailsSceneTableViewDelegate: NSObject {
    weak var viewController: UserDetailsSceneTableViewLogic?

    init(viewController: UserDetailsSceneTableViewLogic?) {
        self.viewController = viewController
    }
}

extension UserDetailsSceneTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let optionSelected = viewController?.tableViewDataSource?.options[indexPath.row] else { return }

        switch optionSelected {
        case .seeAllAlbums:
            break
        case .markAsFavorite:
            viewController?.toggleFavoriteStatus()
        }
    }
}
