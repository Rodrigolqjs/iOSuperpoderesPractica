//
//  BaseNetwork.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import Foundation

struct BaseNetwork {

    func getMarvelHeroesSession() -> URLRequest {
        let urlStr: String = "https://gateway.marvel.com/v1/public/characters?apikey=79909a0fbc346cc9a495ed5b108a6366&ts=1&hash=cb5a4b94da562f6d80faac14c5becd32&orderBy=-modified"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
    
        return request
    }
    
    func getMarvelHeroesURLSession(resourceURI: String) -> URLRequest{
        let urlStr: String = "\(resourceURI)?apikey=79909a0fbc346cc9a495ed5b108a6366&ts=1&hash=cb5a4b94da562f6d80faac14c5becd32&orderBy=-modified"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        return request
    }
    
    func getMarvelHeroesSeries(heroId: String) -> URLRequest{
        let urlStr: String = "https://gateway.marvel.com/v1/public/characters/\(heroId)/series?apikey=79909a0fbc346cc9a495ed5b108a6366&ts=1&hash=cb5a4b94da562f6d80faac14c5becd32&orderBy=-modified"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        return request
    }
}

