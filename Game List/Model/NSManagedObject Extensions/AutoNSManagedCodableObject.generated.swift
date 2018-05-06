// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
import Foundation

// MARK: Genre type

extension Genre: Codable {
  enum CodingKeys: String, CodingKey {
      case id
      case name
      case created_at
      case updated_at
      case url
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(name, forKey: .name)
      try container.encode(created_at, forKey: .created_at)
      try container.encode(updated_at, forKey: .updated_at)
      try container.encode(url, forKey: .url)
  }

  public func customDecoder(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(Int32.self, forKey: .id)
      name = try values.decode(String?.self, forKey: .name)
      created_at = try values.decode(Int64.self, forKey: .created_at)
      updated_at = try values.decode(Int64.self, forKey: .updated_at)
      url = try values.decode(String?.self, forKey: .url)
  }
}
