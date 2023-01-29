//
//  MarvelHeroesDetailView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 13/12/22.
//

import Foundation
import Combine

final class MarvelHeroesViewModel: ObservableObject {
    @Published var heroes: [MarvelHeroModel]?
    
    private var suscriptors = Set<AnyCancellable>()
    
    init() {
        getMarvelHeroes()
    }
    
    func CancelAll(){
        //cancelar suscriptores
        suscriptors.forEach { AnyCancellable in
            AnyCancellable.cancel()
        }
    }
    
    
    func getMarvelHeroes() {
        CancelAll()
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getMarvelHeroesSession())
            .tryMap { hero in
                guard let response = hero.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                      }
                return hero.data
            }
            .decode(type: MarvelDataModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Todo ok getHeroes")
                case .failure(let error):
                    print("entro case failure con error\(error)")
                }
            } receiveValue: { receivedHeroes in
                self.heroes = receivedHeroes.data.results
            }
            .store(in: &suscriptors)
        
    }
}
