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
        
        guard let requst = makeRequst(nextPage: nextPage) else {
            assertionFailure("Invalid requst")
            return
        }
        
        let session = URLSession.shared
        curenTask = session.objectTask(for: requst) { [weak self] (responce: Result<[PhotoResult], Error>) in
            guard let self else { return }
            switch responce {
            case .success(let photoResults):
                let newPhotos = photoResults.map { Photo(from: $0) }
                self.photos.append(contentsOf: newPhotos)
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification,
                                                object: self,
                                                userInfo: ["Photos": self.photos])
                self.curenTask = nil
            case .failure(let error):
                assertionFailure("Failed to create Photo from JSON \(error)", file: #file, line: #line)
                self.curenTask = nil
            }
        }
    }
}

extension ImagesListService {
    private func makeRequst(nextPage: Int) -> URLRequest? {
        builder.makeHTTPRequset(
            path: "/photos?page=\(nextPage)",
            httpMethod: "GET",
            baseURLString: defaultBaseURL
        )
    }
}

