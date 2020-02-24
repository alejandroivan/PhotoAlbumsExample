import UIKit

enum UsersScene {
    enum FetchAll {
        struct Request {
            let favoritesOnly: Bool
        }

        struct Response {
            let favoritesOnly: Bool
            let users: Users
        }

        struct ViewModel {
            let favoritesOnly: Bool
            let users: Users
        }
    }
}
