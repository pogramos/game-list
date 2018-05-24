// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import CoreData

extension Genre {
  enum CodingKeys: String, CodingKey {
      case id
      case url
      case name
  }

  static func fields() -> String {
    let fields = "id,url,name,"
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
    return equivalent
  }
}
extension CoreDataGenre {
  func toModel() -> Genre {
    var model = Genre()
    model.id = id
    model.url = url
    model.name = name
    return model
  }
}
