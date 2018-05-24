// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import CoreData

extension Game {
  enum CodingKeys: String, CodingKey {
      case id
      case name
      case summary
      case storyline
      case cover
      case screenshots
  }

  static func fields() -> String {
    let fields = "id,name,summary,storyline,cover,screenshots"
    return fields
  }
  func toCoreData(on context: NSManagedObjectContext) -> CoreDataGame {
    let equivalent = CoreDataGame(context: context)
    if let id = id {
      equivalent.id = id
    }
    if let name = name {
      equivalent.name = name
    }
    if let summary = summary {
      equivalent.summary = summary
    }
    if let storyline = storyline {
      equivalent.storyline = storyline
    }
    return equivalent
  }
}
extension CoreDataGame {
  func toModel() -> Game {
    var model = Game()
    model.id = id
    model.name = name
    model.summary = summary
    model.storyline = storyline
    return model
  }
}
