
import Foundation

struct Developer: Codable, Identifiable {
    let bootcamp: Bootcamp
    let id, apell1, apell2, email: String
    let name: String
    let photo: String
    let heros: [Heroes] // Heroes favoritos del dev
}

struct Bootcamp: Codable, Identifiable {
    let id: String
    let name: String
}
