//
//  BaseNetwork.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import Foundation

let server = "https://dragonball.keepcoding.education"

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"
}

enum endpoints: String {
    case login = "/api/auth/login"
    case heroesList = "/api/heros/all"
    case developersList = "/api/data/developers"
    case bootcampsList = "/api/data/bootcamps"
    case like = "/api/data/herolike"
    case register = "/api/register/developer"
}

struct BaseNetwork {
    
    func getSessionRegister(data: RegisterModel) -> URLRequest {
        let urlStr: String = "\(server)\(endpoints.register.rawValue)"
        var request = URLRequest(url: URL(string: urlStr)!)
        
        request.httpMethod = HTTPMethods.post
        
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        request.httpBody = try? JSONEncoder().encode(data)
        
        return request
    }
    
    func getSessionLogin(user: String, password: String) -> URLRequest {
        let urlStr: String = "\(server)\(endpoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredentials = ""
        
        if let credentials = encodeCredentials {
            segCredentials = "Basic \(credentials)"
        }
        
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredentials, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getSessionHeroes(heroName: String) -> URLRequest {
        let urlStr: String = "\(server)\(endpoints.heroesList.rawValue)"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = HTTPMethods.post
        
        request.httpBody = try? JSONEncoder().encode(HeroesFilter(name: heroName))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        let token = read(key: CONST_TOKEN_ID)
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    func getSessionDevelopers() -> URLRequest {
        let urlStr: String = "\(server)\(endpoints.developersList.rawValue)"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = HTTPMethods.get
        
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        let token = read(key: CONST_TOKEN_ID)
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    func getSessionBootcamps() -> URLRequest {
        let urlStr: String = "\(server)\(endpoints.bootcampsList.rawValue)"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        return request
    }
    
    func getSessionLike(idHero: String) -> URLRequest {
        let urlStr: String = "\(server)\(endpoints.like.rawValue)"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = HTTPMethods.post
        
        request.httpBody = try? JSONEncoder().encode(HeroLikeRequest(hero: idHero))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        let token = read(key: CONST_TOKEN_ID)
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

