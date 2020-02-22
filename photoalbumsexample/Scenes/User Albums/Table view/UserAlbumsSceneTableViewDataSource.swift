import UIKit

class UserAlbumsSceneTableViewDataSource: NSObject {
    weak var viewController: (UserAlbumsSceneTableViewLogic & UserAlbumsSceneDisplayLogic)?

    init(viewController: (UserAlbumsSceneTableViewLogic & UserAlbumsSceneDisplayLogic)?) {
        self.viewController = viewController
    }
}

extension UserAlbumsSceneTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewController!.albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = viewController?.albums[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = album?.title
        return cell
    }
}
