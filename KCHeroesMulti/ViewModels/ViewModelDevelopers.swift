
import Foundation
import Combine

final class ViewModelDevelopers: ObservableObject {
    @Published var developers: [Developer]?
    @Published var status = Status.none
    var suscriptors = Set<AnyCancellable>()
    
    public init(testing: Bool = false, bootcamps: [Bootcamp] = []) {
        if (testing) {
            getDeveloperDesing(bootcamps: bootcamps)
        } else {
            getDevelopers()
        }
        NotificationCenter.default
            .publisher(for: .kcNotificationReloadKeepcoders)
            .map {
                $0.object as? String
            }
            .replaceError(with: "error")
            .replaceNil(with: "vacio")
            .replaceEmpty(with: "empty")
            .sink { _ in
                self.getDevelopers()
            }
    }
    
    func getDevelopers() {
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionDevelopers())
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return $0.data
            }
            .decode(type: [Developer].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        self.status = .loaded
                    case .failure(let error):
                    print(error)
                        self.status = .error(error: "Error en la llamada a los Developers")
                }
            } receiveValue: { developers in
                self.developers = developers
            }
            .store(in: &suscriptors)

    }
    
    func getDevelopersBootcamps(id: String) -> [Developer] {
        return developers!
            .filter { $0.bootcamp.id == id}
//        var developers: [Developer] = []
//        for developer in developers {
//            if developer.bootcamp.id == id {
//                developers.append(developer)
//            }
//        }
//        return developers
    }
    
    func getDeveloperDesing(bootcamps: [Bootcamp]) {
        let b1 = Bootcamp(id: bootcamps[0].id, name: bootcamps[0].name)
        let b2 = Bootcamp(id: bootcamps[1].id, name: bootcamps[1].name)
        
        let dev1 = Developer(bootcamp: b1, id: "100", apell1: "Latorre", apell2: "Quispe", email: "rodrigo.latorre.quispe@gmail.com", name: "Rodrigo", photo: "https://cdn-employer-wp.arc.dev/wp-content/uploads/2022/04/good-software-developer-1128x635.jpg", heros: [])
        
        let dev2 = Developer(bootcamp: b1, id: "200", apell1: "Benes", apell2: "Pains", email: "rodrigo.latorre.quispe@gmail.com", name: "Erick", photo: "https://cdn-employer-wp.arc.dev/wp-content/uploads/2022/04/good-software-developer-1128x635.jpg", heros: [])
        
        let dev3 = Developer(bootcamp: b2, id: "300", apell1: "Sanchez", apell2: "Fernandez", email: "rodrigo.latorre.quispe@gmail.com", name: "Alonso", photo: "https://cdn-employer-wp.arc.dev/wp-content/uploads/2022/04/good-software-developer-1128x635.jpg", heros: [])
        
        let dev4 = Developer(bootcamp: b2, id: "400", apell1: "Gomez", apell2: "Lizarraga", email: "rodrigo.latorre.quispe@gmail.com", name: "Shakira", photo: "https://cdn-employer-wp.arc.dev/wp-content/uploads/2022/04/good-software-developer-1128x635.jpg", heros: [])
        
        self.developers = [dev1, dev2, dev3, dev4]
    }
}
