import UIKit

class UsersSceneWorker {
    func fetchAllUsers(completion: @escaping (_ success: Bool, _ users: Users) -> Void) {
        let url = Constants.API.users

        ApiClient.get(
            url,
            success: { data in
                do {
                    let users = try JSONDecoder().decode(Users.self, from: data)
                    completion(true, users)
                } catch {
                    completion(false, [])
                }
            },
            failure: { _ in
                completion(false, [])
            }
        )
    }
}
