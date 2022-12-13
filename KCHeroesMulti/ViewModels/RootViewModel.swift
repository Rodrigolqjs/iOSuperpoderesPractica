//
//  RootViewModel.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import Foundation
import Combine

public let CONST_TOKEN_ID = "TokenJWTKeyChainKeepCoding2022"

final class RootViewModel: ObservableObject {
    @Published var status = Status.none
    @Published var bootcamps: [Bootcamp]?
    /*
    @Published var tokenJWT: String = "" {
        didSet {
            if tokenJWT != "" {
                save(key: CONST_TOKEN_ID, value: tokenJWT)
                print("Token: \(tokenJWT)")
            }

        }
    }
     */
    @kcPersistenceKeyChain(key: CONST_TOKEN_ID) var tokenJWT
    
    private var suscriptor = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        self.logedUserControl()
        if (!testing) {
            loadBootcamps()
        } else {
            loadBootcampsTesting()
        }
    }
    
    func logedUserControl() {
        if tokenJWT != "" {
            self.status = .loaded
        }
    }
    
    /*
    func logedUserControl() {
        guard let tokenSaved = read(key: CONST_TOKEN_ID) else { return }
        tokenJWT = tokenSaved
        if tokenSaved.count > 0 {
            self.status = .loaded
        }
    }
     */
    
    func login(user: String, password: String) {
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionLogin(user: user, password: password))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return String(decoding: $0.data, as: UTF8.self)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Usuario y/o clave incorrectos")
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { token in
                self.tokenJWT = token
            }
            .store(in: &suscriptor)

    }
    
    func closeSession() {
        self.tokenJWT = ""
        self.status = .none
    }
    
    //Funciones de testing de Bootcamps
    
    func loadBootcamps() {
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionBootcamps())
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: [Bootcamp].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Usuario y/o clave incorrectos")
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { bootcamps in
                self.bootcamps = bootcamps
            }
            .store(in: &suscriptor)


        
    }
    
    func loadBootcampsTesting() {
        let b1 = Bootcamp(id: UUID().uuidString, name: "Mobile 11")
        let b2 = Bootcamp(id: UUID().uuidString, name: "Mobile 12")
        let b3 = Bootcamp(id: UUID().uuidString, name: "Mobile 13")
        let b4 = Bootcamp(id: UUID().uuidString, name: "Mobile 14")
        self.bootcamps = [b1, b2, b3, b4]
    }

}


