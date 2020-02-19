import Foundation

struct Address: Decodable {
    let geolocation: Geolocation
    let street: String
    let suite: String
    let zipCode: String
    let city: String

    private enum CodingKeys: String, CodingKey {
        case street, suite, city
        case geolocation = "geo"
        case zipCode = "zipcode"
    }
}
