typealias Users = [User]

struct User: Decodable {
    let phone: String?
    let website: String?
    let address: Address?
    let id: Int
    let company: Company?
    let username: String
    let email: String?
    let name: String
}
