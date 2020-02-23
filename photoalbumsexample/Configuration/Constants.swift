import UIKit

struct Constants {
    struct API {
        static let base = URL(string: "https://jsonplaceholder.typicode.com/")!
        static let users = URL(string: "users", relativeTo: base)!.absoluteURL
        static let albums = URL(string: "albums", relativeTo: base)!.absoluteURL
        static let photos = URL(string: "photos", relativeTo: base)!.absoluteURL
    }

    struct Parameters {
        static let userId = "userId"
        static let albumId = "albumId"
    }

    enum ErrorView {
        static let message = "Hubo un problema al cargar la información de Internet. Toca para reintentar."
        static let font = UIFont.systemFont(ofSize: 12, weight: .light)
        static let insets = UIEdgeInsets(top: 2, left: 4, bottom: -2, right: -4)
    }

    enum CollectionView {
        static let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
