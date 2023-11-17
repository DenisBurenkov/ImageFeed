import Foundation

class OAuth2TokenStorage {
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "BearerToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "BearerToken")
        }
    }
}
