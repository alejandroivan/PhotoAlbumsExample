import UIKit

enum UsersScene {
    enum FetchAll {
        struct Request {
            let favoritesOnly: Bool
        }

        struct Response {
            let users: Users
        }

        struct ViewModel {
            let users: Users
        }
    }
}
