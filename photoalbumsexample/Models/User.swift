import Foundation

typealias Users = [User]

struct User: Decodable {
    private static let favoritesKey = "favorite_users"

    let phone: String?
    let website: String?
    let address: Address?
    let id: Int
    let company: Company?
    let username: String
    let email: String?
    let name: String
}

extension User {
    var isFavorite: Bool {
        // We'll use UserDefaults for simplicity, and a dictionary because of its O(1) access time
        get {
            let userId = String(id)
            let dict = UserDefaults.standard.dictionary(forKey: type(of: self).favoritesKey)
            return (dict?[userId] as? Bool) ?? false
        }

        set {
            let userId = String(id)
            var favorites = UserDefaults.standard.dictionary(forKey: type(of: self).favoritesKey) ?? [String:Any]()

            favorites[userId] = newValue
            UserDefaults.standard.set(favorites, forKey: type(of: self).favoritesKey)
        }
    }
}
