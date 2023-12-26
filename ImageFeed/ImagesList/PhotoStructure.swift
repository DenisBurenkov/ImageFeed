import UIKit

 struct PhotoResult: Codable {
     let id: String
     let createdAt: String
     let width: Int
     let height: Int
     let description: String?
     var likedByUser: Bool
     let urls: UrlsResult

     enum CodingKeys: String, CodingKey {
         case id
         case width
         case height
         case description
         case createdAt = "created_at"
         case likedByUser = "liked_by_user"
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

extension Photo {
    init(from photoResult: PhotoResult) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let date = dateFormatter.date(from: photoResult.createdAt)

        self.init(
            id: photoResult.id,
            size: CGSize(width: photoResult.width, height: photoResult.height),
            createdAt: date,
            welcomeDescription: photoResult.description,
            thumbImageURL: photoResult.urls.thumb,
            largeImageURL: photoResult.urls.full,
            isLiked: photoResult.likedByUser
        )
    }
}
