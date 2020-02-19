typealias Albums = [Album]

struct Album: Decodable {
    let id: Int
    let userId: Int
    let title: String
}
