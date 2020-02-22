import Foundation

struct Constants {
    struct API {
        static let base = URL(string: "https://jsonplaceholder.typicode.com/")!
        static let users = URL(string: "users", relativeTo: base)!.absoluteURL
        static let albums = URL(string: "albums", relativeTo: base)!.absoluteURL
        static let photos = URL(string: "photos", relativeTo: base)!.absoluteURL
    }

    struct Parameters {
        static let userId = "userId"
    }

    enum ErrorView {
        static let message = "Hubo un problema al cargar la información de Internet. Toca para reintentar."
    }
}
