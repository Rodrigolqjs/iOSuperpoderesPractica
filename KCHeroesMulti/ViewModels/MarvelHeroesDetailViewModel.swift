//
//  MarvelHeroesDetailViewModel.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 28/01/23.
//

import Foundation
import Combine

final class MarvelHeroesDetailViewModel: ObservableObject {
    @Published var series: [HeroSeriesModel]?
    @Published var status: Status = Status.loading
    
    private var suscriptors = Set<AnyCancellable>()
    
    func getMarvelHeroesSeries(heroId: String) {
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getMarvelHeroesSeries(heroId: heroId))
            .tryMap { url in
                guard let response = url.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return url.data
            }
            .decode(type: MarvelHeroeURLModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Todo ok getHeroesSeries")
                    self.status = .loaded
                case .failure(let error):
                    print("entro case failure con error\(error)")
                }
            } receiveValue: { marvelHeroes in
                let convertedArray: [HeroSeriesModel] = marvelHeroes.data.results.map { (result) -> HeroSeriesModel in
                    return HeroSeriesModel(id: result.id,
                                           title: result.title,
                                           desc: result.description,
                                           urlPath: "\(result.thumbnail.path).\(result.thumbnail.thumbnailExtension)")
                }
                self.series = convertedArray
            }
            .store(in: &suscriptors)
    }
    
}
