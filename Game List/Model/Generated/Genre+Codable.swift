// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import CoreData

extension Genre {
  enum CodingKeys: String, CodingKey {
      case id
      case url
      case name
      case created_at
      case updated_at
  }

  static func fields() -> String {
    let fields = "id,url,name,created_at,updated_at"
    return fields
  }
  func toCoreData(on context: NSManagedObjectContext) -> CoreDataGenre {
    let equivalent = CoreDataGenre(context: context)
    if let id = id {
      equivalent.id = id
    }
    if let url = url {
      equivalent.url = url
    }
    if let name = name {
      equivalent.name = name
    }
    if let created_at = created_at {
      equivalent.created_at = created_at
    }
    if let updated_at = updated_at {
      equivalent.updated_at = updated_at
    }
    return equivalent
  }
}
extension CoreDataGenre {
  func toModel() -> Genre {
    var model = Genre()
    model.id = id
    model.url = url
    model.name = name
    model.created_at = created_at
    model.updated_at = updated_at
    return model
  }
}
