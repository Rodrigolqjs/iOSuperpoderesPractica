//
//  ProportyWrappers.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import Foundation

@propertyWrapper
class kcPersistenceKeyChain {
    private var key: String
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: String {
        set {
            save(key: key, value: newValue)
            print("Token: \(newValue)")
        }
        
        get {
            if let value = read(key: key) {
                return value
            } else {
                return ""
            }
        }
    }
    
}
