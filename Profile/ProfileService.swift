import UIKit
import Kingfisher

final class ProfileService {
    
    static let shared = ProfileService()
    private var curenTask: URLSessionTask?
    private (set) var profile: Profile?
    private let builder: URLReqestBuilder
    
    init(
        builder: URLReqestBuilder = .shared
    ) {
        self.builder = builder
    }
    
    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void){
        curenTask?.cancel()
        
        guard let requst = makeFethProfilRequst() else {
            assertionFailure("Invalid requst")
            completion(.failure(NetworkError.inavalidRequest))
            return
        }
        
        let session = URLSession.shared
        curenTask = session.objectTask(for: requst) { [weak self] (responce: Result<ProfileResult, Error>) in
            self?.curenTask = nil
            switch responce {
            case .success(let profileResult):
                let profile = Profile(result: profileResult)
                self?.profile = profile
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension ProfileService {
    private func makeFethProfilRequst() -> URLRequest? {
        builder.makeHTTPRequset(
            path: "/me",
            httpMethod: "GET",
            baseURLString: defaultBaseURL
        )
    }
}
