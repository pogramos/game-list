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
                            let parameters = Parameters([
                                "fields": "id,name,created_at,updated_at,url" as AnyObject
                                ])
                            IGDBApi.getGenres(with: parameters, on: viewContext, success: { (genres) in
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
                            let parameters = Parameters([
                                "fields": "id,name,summary,storyline" as AnyObject
                                ])
                            IGDBApi.getGame(for: 12, with: parameters, on: viewContext, success:  { games in
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
                            let parameters = Parameters([
                                "fields": "id,name,summary,storyline" as AnyObject
                                ])
                            IGDBApi.getGames(with: parameters, on: viewContext, success:  { games in
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
