import Foundation

struct Geolocation: Decodable {
    let latitude: String
    let longitude: String

    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
