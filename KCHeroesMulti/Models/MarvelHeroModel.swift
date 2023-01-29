//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let reqResListado = try? newJSONDecoder().decode(ReqResListado.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Comics
//struct Comics: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [ComicsItem]
//    let returned: Int
//}
//
//// MARK: - ComicsItem
//struct ComicsItem: Codable {
////    var id = UUID()
//
//    let resourceURI: String
//    let name: String
//}
//struct Thumbnail: Codable {
//    let path: String
//    let thumbnailExtension: Extension
//
//    enum CodingKeys: String, CodingKey {
//        case path
//        case thumbnailExtension = "extension"
//    }
//}
//
//enum Extension: String, Codable {
//    case jpg = "jpg"
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reqResListado = try? JSONDecoder().decode(ReqResListado.self, from: jsonData)

import Foundation

// MARK: - ReqResListado
struct MarvelDataModel: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let results: [MarvelHeroModel]
}

// MARK: - Result
struct MarvelHeroModel: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let series: Comics
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}
