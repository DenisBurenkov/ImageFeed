import Foundation
import UIKit

struct PhotoResult: Codable {
    let id: String
    let createdAt: Date
    let width: Int
    let height: Int
    let description: String?
    var isLiked: Bool
    let urls: UrlsResult
    
    var size: CGSize {
        return CGSize(width: Double(width), height: Double(height))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case description
        case createdAt = "created_at"
        case isLiked = "liked_by_user"
        case urls
    }
}

struct UrlsResult: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
}
