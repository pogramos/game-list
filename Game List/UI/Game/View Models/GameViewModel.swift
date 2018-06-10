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

    fileprivate enum ImageType: String {
        case cover = "_cover_big_2x"
        case screenshot = "_screenshot_med_2x"
    }

    var title: String? {
        return coreDataGame?.name
    }

    var release: String? {
        return game?.first_release_date?.toDateString() ?? ""
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

    /// Check the existance of a game in the CoreDataModel
    ///
    /// - Parameter id: identifier of a game
    /// - Returns: A representation of a game that was saved localy for a given **id**, otherwise nil
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

    fileprivate func makeUrl(_ url: String, for type: ImageType) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "t_([a-zA-Z0-9]+)", options: .caseInsensitive)
            let range = NSMakeRange(0, url.count)
            let newUrl = regex.stringByReplacingMatches(in: url, options: [], range: range, withTemplate: type.rawValue)
            return newUrl
        } catch {
            return ""
        }
    }

    fileprivate func downloadCover(from url: String, completion: @escaping (Data?) -> Void) {
        IGDBApi.downloadImage(from: makeUrl(url, for: .cover)) { (imageData, error) in
            if let error = error {
                print(error)
            }
            self.coreDataGame?.cover = imageData
            DataController.shared.save()
            performUIUpdatesOnMain {
                completion(imageData)
            }
        }
    }
}

extension GameViewModel: GameViewModelProtocol {
    func fetchCoverImage(_ completion: @escaping (Data?) -> Void) {
        if let data = coreDataGame?.cover {
            completion(data)
        } else {
            if let url = game?.cover?.url {
                downloadCover(from: url, completion: completion)
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
