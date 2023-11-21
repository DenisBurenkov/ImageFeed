import Foundation

class OAuth2TokenStorage {
    
    private let bearerToken = "BearerToken"
    
    static var shared: OAuth2TokenStorage {
        return sharedInstance
    }
    
    private static let sharedInstance = OAuth2TokenStorage()
    private init() {}
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: bearerToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bearerToken)
        }
    }
}
