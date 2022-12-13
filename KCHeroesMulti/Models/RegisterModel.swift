//
//  RegisterModel.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 13/12/22.
//

import Foundation

struct RegisterModel: Codable {
    var name: String
    var apell1: String
    var apell2: String
    var email: String
    var password: String
    var bootcamp: String
    var photo: String
    
    var isValidPassword: String
    
    init() {
        name = ""
        apell1 = ""
        apell2 = ""
        email = ""
        password = ""
        bootcamp = ""
        photo = ""
        isValidPassword = ""
    }
    
    func passwordValidation() -> Bool {
        if (password != isValidPassword || password.count < 6) {
            return false
        }
        return true
    }
    
    func emailValidation() -> Bool {
        //Expresion regular para validar Email
        let exReguEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let validationEmailPred = NSPredicate(format: "SELF MATCHES %@", exReguEmail)
        return validationEmailPred.evaluate(with: email)
    }
    
    func validData() -> Bool {
        if (passwordValidation() &&
            emailValidation() &&
            name.count > 0 &&
            apell1.count > 0 &&
            apell2.count > 0 &&
            photo.count > 0)
        {
            return true
        } else {
            return false
        }
    }
    
}
