import Foundation
import SwiftKeychainWrapper

class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    
    private let keychainWrapper = KeychainWrapper.standard
    
    var token: String? {
        get {
            keychainWrapper.string(forKey: bearerToken)
        }
        set {
            guard let newValue else { return }
            keychainWrapper.set(newValue, forKey: bearerToken)
        }
    }
}
