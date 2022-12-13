import Foundation
import KeychainSwift

@discardableResult
func save(key: String, value: String) -> Bool {
    guard let data = value.data(using: .utf8) else { return false }
    let keychain = KeychainSwift()
    keychain.set(data, forKey: key)
    return true
}

func read(key: String) -> String? {
    let keychain = KeychainSwift()
    guard let data = keychain.get(key) else { return "" }
    return data
}

func delete(key: String) {
    let keychain = KeychainSwift()
    keychain.delete(key)
    return
}
