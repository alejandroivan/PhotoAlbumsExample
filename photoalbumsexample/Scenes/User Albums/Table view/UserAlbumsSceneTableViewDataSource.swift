import UIKit

class UserAlbumsSceneTableViewDataSource: NSObject {
    weak var viewController: UserAlbumsSceneTableViewLogic?

    init(viewController: UserAlbumsSceneTableViewLogic?) {
        self.viewController = viewController
    }
}

extension UserAlbumsSceneTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }


}
