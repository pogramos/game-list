// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation

extension Image {
  enum CodingKeys: String, CodingKey {
      case url
  }

  static func fields() -> String {
    let fields = "url,"
    return fields
  }
}
