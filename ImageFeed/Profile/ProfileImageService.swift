import Foundation

final class ProfileImageService {
    
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    private var curenTask: URLSessionTask?
    private (set) var avatarURL: URL?
    private let builder = URLReqestBuilder.shared
    
    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void){
        assert(Thread.isMainThread)
        
        guard let requst = makeFethProfilRequst(username: username) else {
            assertionFailure("Invalid requst")
            completion(.failure(NetworkError.inavalidRequest))
            return
        }
        
        let session = URLSession.shared
        let task = session.objectTask(for: requst) { [weak self] (responce: Result<ProfileResult, Error>) in
            guard let self else { return }
            self.curenTask = nil
            
            switch responce {
            case .success(let profilePhoto):
                guard let largePhoto = profilePhoto.profileImage?.large else { return }
                self.avatarURL = URL(string: largePhoto)
                completion(.success(largePhoto))
                NotificationCenter.default.post(name: ProfileImageService.didChangeNotification, object: self, userInfo: ["URL": largePhoto])
            case .failure(let error):
                completion(.failure(error))
            }
            self.curenTask = nil
        }
        self.curenTask = task
        task.resume()
    }
}

extension ProfileImageService {
    private func makeFethProfilRequst(username: String) -> URLRequest? {
        builder.makeHTTPRequset(
            path: "/users/\(username)",
            httpMethod: "GET",
            baseURLString: defaultBaseURL
        )
    }
}
