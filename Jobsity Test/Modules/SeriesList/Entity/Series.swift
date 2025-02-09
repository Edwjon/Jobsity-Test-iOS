import UIKit

struct Series: Codable {
    let id: Int
    let name: String
    let image: Image?
    let schedule: Schedule
    let genres: [String]
    let summary: String?

    struct Image: Codable {
        let medium: String
        let original: String
    }

    struct Schedule: Codable {
        let time: String
        let days: [String]
    }
}

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: Series.Image?
}
