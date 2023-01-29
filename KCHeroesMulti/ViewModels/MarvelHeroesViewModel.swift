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
    
    
    //Estas dos funciones se pueden volver una.
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
    
//    func getMarvelHeroesSeriesURL(marvelHero: MarvelHeroModel) {
//        CancelAll()
//        print(marvelHero)
//        marvelHeroesSeries = []
//        marvelHero.series.items.forEach { serie in
//            URLSession.shared
//                .dataTaskPublisher(for: BaseNetwork().getMarvelHeroesURLSession(resourceURI: serie.resourceURI))
//                .tryMap { url in
//                    guard let response = url.response as? HTTPURLResponse,
//                          response.statusCode == 200 else {
//                        throw URLError(.badServerResponse)
//                    }
//                    return url.data
//                }
//                .decode(type: MarvelHeroeURLModel.self, decoder: JSONDecoder())
//                .receive(on: DispatchQueue.main)
//                .sink { completion in
//                    switch completion {
//                    case .finished:
//                        print("Todo ok getHeroesSeries")
//                    case .failure(let error):
//                        print("entro case failure con error\(error)")
//                    }
//                } receiveValue: { marvelHeroes in
//                    let convertedArray: [HeroSeriesModel] = marvelHeroes.data.results.map { (result) -> HeroSeriesModel in
//                        return HeroSeriesModel(id: result.id,
//                                               title: result.title,
//                                               //                                               desc: result.description,
//                                               urlPath: "\(result.thumbnail.path).\(result.thumbnail.thumbnailExtension)")
//                    }
//
//                    self.marvelHeroesSeries?.append(convertedArray[0])
//                }
//                .store(in: &suscriptors)
//        }
//    }
}
