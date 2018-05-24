//
//  GameListClientTests.swift
//  Game ListTests
//
//  Created by Guilherme Ramos on 12/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Quick
import Nimble
import CoreData
@testable import Game_List

class GameListClientTests: QuickSpec {
    override func spec() {
        describe("IGDB service") {
            describe("GET method") {
                var viewContext: NSManagedObjectContext!
                beforeEach {
                    viewContext = setupMemoryViewContext()
                }
                context("for genres") {
                    it("should return a list of genres") {
                        waitUntil(timeout: 10) { done in
                            IGDBApi.getGenres(with: Parameters(), success: { (genres) in
                                expect(genres).toNot(beNil())
                                done()
                            }, failure: { (error) in
                                fail(error.localizedDescription)
                                done()
                            })
                        }
                    }
                }

                context("for game with id 12") {
                    it("should return a game") {
                        waitUntil(timeout: 10) { done in
                            IGDBApi.getGame(for: 12, with: Parameters(), success:  { games in
                                expect(games).toNot(beNil())
                                done()
                            }, failure: { (error) in
                                fail(error.localizedDescription)
                                done()
                            })
                        }
                    }
                }

                context("for games from the genre with id 9") {
                    it("should return a list of games") {
                        waitUntil(timeout: 10) { done in
                            var genre = Genre()
                            genre.id = 9
                            IGDBApi.getGames(for: genre, with: Parameters(), success:  { games in
                                expect(games).toNot(beNil())
                                done()
                            }, failure: { (error) in
                                fail(error.localizedDescription)
                                done()
                            })
                        }
                    }
                }
            }
        }
    }
}
