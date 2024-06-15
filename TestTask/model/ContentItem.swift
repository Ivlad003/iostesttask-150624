import Foundation

struct ContentItem: Identifiable, Codable {
    let id = UUID() // You don't need this line for decoding, remove if necessary
    let title: String
    let description: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL
    }
}

