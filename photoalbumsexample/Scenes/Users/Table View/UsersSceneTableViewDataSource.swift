import UIKit

class UsersSceneTableViewDataSource: NSObject {
    weak var viewController: UsersSceneTableViewLogic?

    init(viewController: UsersSceneTableViewLogic?) {
        self.viewController = viewController
    }
}

extension UsersSceneTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewController?.users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "UsersTableViewCell",
            for: indexPath
        ) as! UsersTableViewCell

        let user = viewController?.users![indexPath.row]

        cell.setup(user: user!)

        return cell
    }
}
