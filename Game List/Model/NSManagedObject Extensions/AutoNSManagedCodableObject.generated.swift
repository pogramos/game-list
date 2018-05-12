// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
import Foundation

// MARK: Game type

extension Game: Codable {
  enum CodingKeys: String, CodingKey {
      case id
      case name
      case summary
      case storyline
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(id, forKey: .id)
          try container.encode(name, forKey: .name)
          try container.encode(summary, forKey: .summary)
          try container.encode(storyline, forKey: .storyline)
  }

  public func customDecoder(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      if values.contains(.id) {
        id = try values.decode(Int64.self, forKey: .id)
      }
      if values.contains(.name) {
        name = try values.decode(String?.self, forKey: .name)
      }
      if values.contains(.summary) {
        summary = try values.decode(String?.self, forKey: .summary)
      }
      if values.contains(.storyline) {
        storyline = try values.decode(String?.self, forKey: .storyline)
      }
  }
}
// MARK: Genre type

extension Genre: Codable {
  enum CodingKeys: String, CodingKey {
      case created_at
      case id
      case name
      case updated_at
      case url
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(created_at, forKey: .created_at)
          try container.encode(id, forKey: .id)
          try container.encode(name, forKey: .name)
          try container.encode(updated_at, forKey: .updated_at)
          try container.encode(url, forKey: .url)
  }

  public func customDecoder(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      if values.contains(.created_at) {
        created_at = try values.decode(Int64.self, forKey: .created_at)
      }
      if values.contains(.id) {
        id = try values.decode(Int32.self, forKey: .id)
      }
      if values.contains(.name) {
        name = try values.decode(String?.self, forKey: .name)
      }
      if values.contains(.updated_at) {
        updated_at = try values.decode(Int64.self, forKey: .updated_at)
      }
      if values.contains(.url) {
        url = try values.decode(String?.self, forKey: .url)
      }
  }
}
// MARK: Screenshot type

extension Screenshot: Codable {
  enum CodingKeys: String, CodingKey {
      case url
      case data
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(url, forKey: .url)
  }

  public func customDecoder(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      if values.contains(.url) {
        url = try values.decode(String?.self, forKey: .url)
      }
  }
}
