//
//  ViewModelHeroes.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 7/12/22.
//

import Foundation
import Combine

final class ViewModelHeroes: ObservableObject {
    @Published var heroes: [Heroes]?
    @Published var status = Status.none
    
    private var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            getHeroesTesting()
        } else {
            getHeroes(filter: "")
        }
    }
    
    func cancelAll() {
        suscriptors.forEach {AnyCancellable in
            AnyCancellable.cancel()
        }
    }
    
    func getHeroes(filter: String) {
        self.status = .loading
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeroes(heroName: filter))
            .tryMap { hero in
                guard let response = hero.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                      }
                return hero.data
            }
            .decode(type: [Heroes].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.status = .loaded
                case .failure(_):
                    self.status = .error(error: "Error buscando Heroes")
                }
            } receiveValue: { heroes in
                self.heroes = heroes
            }
            .store(in: &suscriptors)

    }
    
    func callToLike(idHero: String) {
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionLike(idHero: idHero))
            .tryMap { hero in
                guard let response = hero.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                      }
                return hero.data
            }
            .decode(type: String.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .replaceError(with: "Error")
            .sink (receiveValue: { data in
                if let offset = self.heroes!.firstIndex(where: {$0.id.uuidString == idHero}) {
                    self.heroes![offset].favorite!.toggle()
                }
                
                NotificationCenter.default.post(name: .kcNotificationReloadKeepcoders, object: "Cambiado heroe de un developer")
            })
            .store(in: &suscriptors)

    }
    
    
    func getHeroesTesting() {
        let testPhotoURL = "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg"
        // Crear un array de 4 heroes y asignarlos a heroes.
        // cambiar el "status" a "loaded"
        self.heroes = [
            Heroes(id: UUID(), name: "test1", description: "testdesc1", photo: testPhotoURL),
            Heroes(id: UUID(), name: "test2", description: "testdesc2", photo: testPhotoURL),
            Heroes(id: UUID(), name: "test3", description: "testdesc3", photo: testPhotoURL)
        ]
        self.status = .loaded
    }
    
    func getHeroesDesing() -> [Heroes] {
        let testPhotoURL = "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg"
        let heroes = [
            Heroes(id: UUID(), name: "test1", description: "testdesc1", photo: testPhotoURL),
            Heroes(id: UUID(), name: "test2", description: "testdesc2", photo: testPhotoURL),
            Heroes(id: UUID(), name: "test3", description: "testdesc3", photo: testPhotoURL)
        ]
        return heroes
    }
    
}
