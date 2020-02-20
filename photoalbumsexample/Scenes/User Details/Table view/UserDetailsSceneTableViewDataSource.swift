import UIKit

class UserDetailsSceneTableViewDataSource: NSObject {
    weak var viewController: UserDetailsSceneTableViewLogic?

    enum ListOptions: String {
        case seeAllAlbums = "Ver todos los álbumes"
        case markAsFavorite = "Marcar como favorito"
    }

    let options: [ListOptions] = [
        .seeAllAlbums,
        .markAsFavorite
    ]

    init(viewController: UserDetailsSceneTableViewLogic?) {
        self.viewController = viewController
    }
}

extension UserDetailsSceneTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let option = options[indexPath.row]
        cell.separatorInset = .zero
        cell.textLabel?.text = option.rawValue

        switch option {
        case .seeAllAlbums:
            cell.selectionStyle = .gray
            cell.accessoryType = .disclosureIndicator
        case .markAsFavorite:
            let isFavorite = viewController?.isUserFavorite ?? false
            cell.selectionStyle = .none
            cell.accessoryType = isFavorite ? .checkmark : .none
        }

        return cell
    }

    
}
