import UIKit

struct Person: Codable {
    let id: Int
    let name: String
    let image: Image?
}

struct Image: Codable {
    let medium: String?
    let original: String?
}
