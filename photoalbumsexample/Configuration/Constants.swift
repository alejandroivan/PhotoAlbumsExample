import Foundation

struct Constants {
    struct API {
        static let base = URL(string: "https://jsonplaceholder.typicode.com/")!
        static let users = URL(string: "/users", relativeTo: base)!
        static let albums = URL(string: "/albums", relativeTo: base)!
        static let photos = URL(string: "/photos", relativeTo: base)!
    }
}
