import Foundation
import KeychainAccess

protocol SecureStorageProtocol: class {
    var authToken: String? { get set }
    var userToken: String? { get set }
    
    func clearSecureStorage()
}

public class SecureStorage: SecureStorageProtocol {
    private enum Keys: String, CustomStringConvertible {
        case authToken
        case userToken
        
        var description: String {
            rawValue
        }
    }
    
    private var keychain: Keychain {
        if CommandLine.arguments.contains("testing") {
            return Keychain(service: "testing-keychain")
        }
        return Keychain(service: Bundle.main.bundleIdentifier ?? "rise-application")
    }
    
    public init() {
        
    }
    
    public var authToken: String? {
        get {
            return keychain[Keys.authToken.description]
        }
        
        set {
            keychain[Keys.authToken.description] = newValue
        }
    }
    
    public var userToken: String? {
        get {
            return keychain[Keys.userToken.description]
        }
        set {
            keychain[Keys.userToken.description] = newValue
        }
    }
    
    public func clearSecureStorage() {
        try? keychain.removeAll()
    }
    
}
