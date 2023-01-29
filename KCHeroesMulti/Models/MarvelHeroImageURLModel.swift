// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reqResListado = try? JSONDecoder().decode(ReqResListado.self, from: jsonData)

import Foundation

// MARK: - ReqResListado
struct MarvelHeroeURLModel: Codable {
    let data: DataClassURL
}

// MARK: - DataClass
struct DataClassURL: Codable {
    let results: [ResultURL]
}

// MARK: - Result
struct ResultURL: Codable {
    let id: Int
    let title: String
    let description: String? // cambie JSONNull
    let thumbnail: ThumbnailURL
}

// MARK: - Thumbnail
struct ThumbnailURL: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct HeroSeriesModel: Identifiable {
    var id: Int
    let title :String
    let desc: String?
    let urlPath: String
}
