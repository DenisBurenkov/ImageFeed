import Foundation

final class OAuth2Service {
    
    private let urlSession: URLSession
    private let builder: URLReqestBuilder
    private var curenTask: URLSessionTask?
    private var lastCode: String?
    private var storage: OAuth2TokenStorage
    
    init(
        urlSession: URLSession = .shared,
        builder: URLReqestBuilder = .shared,
        storage: OAuth2TokenStorage = .shared
    ) {
        self.urlSession = urlSession
        self.builder = builder
        self.storage = storage
    }
    
    var isAuthenticated: Bool {
        storage.token != nil 
    }
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard !(code == lastCode && curenTask != nil) else {
            return
        }
        
        lastCode = code
        guard let requst = makeRequest(code: code) else {
            assertionFailure("Invalid requst")
            completion(.failure(NetworkError.inavalidRequest))
            return
        }
        
        let session = URLSession.shared
        curenTask = session.objectTask(for: requst) { [weak self] (responce: Result<OAuthTokenResponseBody, Error>) in
            self?.curenTask = nil
            switch responce {
            case .success(let body):
                let authToken = body.accessToken
                self?.storage.token = authToken
                completion(.success(authToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}



extension OAuth2Service {
    private func makeRequest(code: String) -> URLRequest? {
        builder.makeHTTPRequset(
            path: "/oauth/token"
            + "?client_id=\(AccessKey)"
            + "&&client_secret=\(SecretKey)"
            + "&&redirect_uri=\(RedirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            httpMethod: "POST",
            baseURLString: unsplashBaseURLString
        )
    }
}
