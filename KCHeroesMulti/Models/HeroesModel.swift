import Foundation

//Para respuesta del Backend
struct Heroes: Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var photo: String
    var favorite: Bool?
}

//Para filtro del Backend
struct HeroesFilter: Codable {
    var name: String
}

struct HeroLikeRequest: Codable {
    var hero: String
}
