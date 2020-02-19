import Foundation
@testable import photoalbumsexample

class UsersSceneWorkerMock: UsersSceneWorker {
    var shouldSuccess = true

    override func fetchAllUsers(completion: @escaping (_ success: Bool, _ users: Users) -> Void) {
        if shouldSuccess {
            // MARK: Success
            let users: Users = [
                User(
                    phone: "11111111",
                    website: nil,
                    address: nil,
                    id: 1,
                    company: nil,
                    username: "aaaa",
                    email: nil,
                    name: "aaaa"
                ),
                User(
                    phone: "22222222",
                    website: nil,
                    address: nil,
                    id: 2,
                    company: nil,
                    username: "bbbb",
                    email: nil,
                    name: "bbbb"
                )
            ]

            completion(true, users)
        } else {
            // MARK: Failure
            completion(false, [])
        }
    }
}
