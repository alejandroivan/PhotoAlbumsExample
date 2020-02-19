import Foundation

typealias Photos = [Photo]

struct Photo: Decodable {
    let id: Int
    let title: String?
    let albumId: Int
    let urlString: String
    let thumbnailUrlString: String

    private enum CodingKeys: String, CodingKey {
        case id, title, albumId
        case urlString = "url"
        case thumbnailUrlString = "thumbnailUrl"
    }
}

extension Photo {
    var url: URL? {
        return URL(string: urlString)
    }

    var thumbnailUrl: URL? {
        return URL(string: thumbnailUrlString)
    }
}
