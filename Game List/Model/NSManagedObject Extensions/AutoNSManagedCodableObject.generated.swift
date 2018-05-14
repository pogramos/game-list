// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
import Foundation

// MARK: Game type

extension Game: Codable {
  enum CodingKeys: String, CodingKey {
      case genres
      case id
      case name
      case storyline
      case summary
      case cover
      case screenshots
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(genres, forKey: .genres)
          try container.encode(id, forKey: .id)
          try container.encode(name, forKey: .name)
          try container.encode(storyline, forKey: .storyline)
          try container.encode(summary, forKey: .summary)
          try container.encode(cover, forKey: .cover)
          try container.encode(screenshots, forKey: .screenshots)
  }

  public func customDecoder(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      if values.contains(.genres) {
        genres = try values.decode(Set<Int>?.self, forKey: .genres)
      }
      if values.contains(.id) {
        id = try values.decode(Int64.self, forKey: .id)
      }
      if values.contains(.name) {
        name = try values.decode(String?.self, forKey: .name)
      }
      if values.contains(.storyline) {
        storyline = try values.decode(String?.self, forKey: .storyline)
      }
      if values.contains(.summary) {
        summary = try values.decode(String?.self, forKey: .summary)
      }
      if values.contains(.cover) {
        cover = try values.decode(Screenshot?.self, forKey: .cover)
      }
      if values.contains(.screenshots) {
        screenshots = try values.decode(Set<Screenshot>?.self, forKey: .screenshots)
      }
  }

  class func fields() -> String {
    let fields = "genres,id,name,storyline,summary,cover,screenshots"
    return fields
  }
}
// MARK: Genre type

extension Genre: Codable {
  enum CodingKeys: String, CodingKey {
      case created_at
      case games
      case id
      case name
      case updated_at
      case url
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(created_at, forKey: .created_at)
          try container.encode(games, forKey: .games)
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
      if values.contains(.games) {
        games = try values.decode(Set<Int>?.self, forKey: .games)
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

  class func fields() -> String {
    let fields = "created_at,games,id,name,updated_at,url"
    return fields
  }
}
// MARK: Screenshot type

extension Screenshot: Codable {
  enum CodingKeys: String, CodingKey {
      case url
      case data
      case cover_game
      case screenshot_games
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(url, forKey: .url)
          try container.encode(data, forKey: .data)
          try container.encode(cover_game, forKey: .cover_game)
          try container.encode(screenshot_games, forKey: .screenshot_games)
  }

  public func customDecoder(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
      if values.contains(.url) {
        url = try values.decode(String?.self, forKey: .url)
      }
  }

  class func fields() -> String {
    let fields = "url,data,cover_game,screenshot_games"
    return fields
  }
}
