//
//  GameListRequestBuilderTests.swift
//  Game ListTests
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Quick
import Nimble
@testable import Game_List

class GameListRequestBuilderTests: QuickSpec {
    override func spec() {
        
        // -------------------------------------------------------------------------
        // MARK: - Parameter Test
        describe("A parameter") {
            describe("query") {
                context("with one key and value") {
                    let parameter = Parameters(["fields": "id,name" as AnyObject])
                    it("should return a string description like key: value") {
                        expect(parameter.description).to(equal("fields=id,name"))
                    }
                }

                context("without parameters") {
                    it("should return an empty description") {
                        expect(Parameters().description).to(equal(""))
                    }
                }
            }
        }

        // -------------------------------------------------------------------------
        // MARK: - Request Test
        describe("A request") {
            var parameter: Parameters!
            beforeEach {
                parameter = Parameters(["fields": "id,name" as AnyObject,"filter[genre][eq]": 1 as AnyObject], headers: ["Accept": "application/json"])
            }

            describe("instance") {

                context("with a keypair on the parameters") {
                    it("should not be nil and have headers") {
                        let request = try? RequestBuilder.buildRequest(scheme: "http", host: "localhost", path: "path", parameters: parameter)
                        expect(request).notTo(beNil())
                        expect(request?.allHTTPHeaderFields?.count).to(equal(1))
                    }
                }

                context("with parameter keypair") {
                    it("should match the expected values") {
                        let request = try? RequestBuilder.buildRequest(scheme: "https", host: "localhost", path: "genres/1", parameters: parameter)
                        expect(request?.url?.absoluteString).to(equal("https://localhost/genres/1?fields=id,name&filter%5Bgenre%5D%5Beq%5D=1"))
                    }
                }

                context("without parameters object") {
                    it ("should not be nil and equal localhost url") {
                        let request = try? RequestBuilder.buildRequest(scheme: "http", host: "localhost", path: "path", parameters: nil)
                        expect(request).notTo(beNil())
                        expect(request?.url?.absoluteURL).to(equal(URL(string: "http://localhost/path")!))
                    }
                }
            }

        }
    }
}
