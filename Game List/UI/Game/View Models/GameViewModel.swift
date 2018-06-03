//
//  GameViewModel.swift
//  Game List
//
//  Created by Guilherme Ramos on 30/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
import CoreData

final class GameViewModel {
    private var game: Game?
    private var coreDataGame: CoreDataGame?

    var title: String? {
        return coreDataGame?.name
    }

    var release: String? {
        return "\(date(with: coreDataGame?.first_release_date))"
    }

    var summary: String? {
        return coreDataGame?.summary ?? "No summary available"
    }

    var favorite: Bool {
        return coreDataGame?.favorite ?? false
    }

    internal init() {}

    init(game: Game) {
        self.game = game
        saveToCoreData()
    }

    init(core: CoreDataGame) {
        coreDataGame = core
    }

    private func date(with number: Int64?) -> String {
        if let number = number, let interval = TimeInterval(exactly: number / 1000) {
            let date = Date(timeIntervalSince1970: interval)
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return ""
    }

    // MARK: coredata

    private func saveToCoreData() {
        guard let id = game?.id else {
            return
        }
        if let cdGame = checkGame(with: id) {
            coreDataGame = cdGame
        } else {
            coreDataGame = game?.toCoreData(on: DataController.shared.viewContext)
        }
    }

    /**
         - parameters:
            - id: the identifier of a game downloaded from the server
        - returns: A representation of a game that was saved localy for a given **id**, otherwise nil
     */
    private func checkGame(with id: Int64) -> CoreDataGame? {
        let fetchRequest: NSFetchRequest<CoreDataGame> = CoreDataGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let results = try DataController.shared.viewContext.fetch(fetchRequest)
            return results.first
        } catch {
            return nil
        }
    }
}

extension GameViewModel: GameViewModelProtocol {
    func fetchImage(_ completion: @escaping (Data?) -> Void) {
        if let data = coreDataGame?.cover {
            completion(data)
        } else {
            if let url = game?.cover?.url {
                IGDBApi.downloadImage(from: url) { (imageData, error) in
                    if let error = error {
                        print(error)
                    }
                    self.coreDataGame?.cover = imageData
                    DataController.shared.save()
                    performUIUpdatesOnMain {
                        completion(imageData)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }

    func toggleFavorite() {
        coreDataGame?.favorite = !favorite
        DataController.shared.save()
    }
}
