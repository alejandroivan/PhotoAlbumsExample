import UIKit

enum UsersScene {
    enum FetchAll {
        struct Request {
        }

        struct Response {
            let users: Users
        }

        struct ViewModel {
            let users: Users
        }
    }
}
