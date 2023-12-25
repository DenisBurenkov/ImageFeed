import UIKit

final class ImagesListService {
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    static let shared = ImagesListService()
    private var curenTask: URLSessionTask?
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int? = nil
    private let builder: URLReqestBuilder
    
    private init(
        builder: URLReqestBuilder = .shared
    ) {
        self.builder = builder
    }
    
    func fetchPhotosNextPage() {
        curenTask?.cancel()
        
        let nextPage = lastLoadedPage == nil ? 1 : lastLoadedPage! + 1
        lastLoadedPage = nextPage
        
        guard let requst = makeHttpRequst(nextPage: nextPage) else {
            assertionFailure("Invalid requst")
            return
        }
        
        let session = URLSession.shared
        curenTask = session.objectTask(for: requst) { [weak self] (responce: Result<[PhotoResult], Error>) in
            guard let self else { return }
            
            self.curenTask = nil
            
            switch responce {
            case .success(let photoResults):
              
                let photosConvertor = photoResults.compactMap { photoResult -> Photo in
                    
                    return Photo(id: photoResult.id,
                                 size: photoResult.size,
                                 createdAt: photoResult.createdAt,
                                 welcomeDescription: photoResult.description,
                                 thumbImageURL: photoResult.urls.thumb,
                                 largeImageURL: photoResult.urls.full,
                                 isLiked: photoResult.isLiked
                    )
                }
                photos.append(contentsOf: photosConvertor)
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification,
                                                object: self,
                                                userInfo: ["Photos": photos])
                
            case .failure(let error):
                assertionFailure("Failed to create Photo")
            }
        }
    }
}

extension ImagesListService {
    private func makeHttpRequst(nextPage: Int?) -> URLRequest? {
        builder.makeHTTPRequset(
            path: "photos?page=\(String(describing: nextPage))&per_page=10",
            httpMethod: "GET",
            baseURLString: defaultBaseURL
        )
    }
}

