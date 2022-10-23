//
//  Breaking_Bad_Tests.swift
//  Breaking Bad Tests
//
//  Created by Louis Vedel on 21/10/2022.
//

import Combine
import SwiftUI
import XCTest

final class Breaking_Bad_Tests: XCTestCase {
    var subscription = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBBCharactersModels() throws {
        let listExpectation = self.expectation(
            description: "Characters fetched successfully."
        )
        let filteredListEmptyExpectation = self.expectation(
            description: "Characters filtered successfully for \"Does not exists\"."
        )
        let filteredListOneExpectation = self.expectation(
            description: "Characters filtered successfully for \"Heisenberg\"."
        )
        let filteredListTwoExpectation = self.expectation(
            description: "Characters filtered successfully for \"Walter White\"."
        )
        let deathExpectation = self.expectation(
            description: "Death status checked successfully."
        )
        let deathInfosExpectation = self.expectation(
            description: "Death infos fetched successfully."
        )
        
        let deathInfosErrorExpectation = self.expectation(
            description: "Death infos error successfully."
        )

        let listModel = BBCharactersListViewModel()
        listModel.$loading.sink { loading in
            if !loading,
               !listModel.characters.isEmpty {
                XCTAssertGreaterThan(listModel.characters.count, 0)
                listExpectation.fulfill()

                listModel.search = "Does not exists"
                XCTAssertEqual(listModel.filteredCharacters().count, 0)
                filteredListEmptyExpectation.fulfill()
                
                listModel.search = "Heisenberg"
                XCTAssertEqual(listModel.filteredCharacters().count, 1)
                filteredListOneExpectation.fulfill()
                
                listModel.search = "Walter White"
                XCTAssertEqual(listModel.filteredCharacters().count, 2)
                filteredListTwoExpectation.fulfill()

                guard let character = listModel.filteredCharacters().first else { return }

                let viewModel = BBCharacterViewModel(character)
                XCTAssertTrue(viewModel.isPossiblyDead())
                deathExpectation.fulfill()

                viewModel.$loading.sink { loading in
                    if !loading,
                       viewModel.death != nil {
                        XCTAssertNotNil(viewModel.death)
                        deathInfosExpectation.fulfill()
                        XCTAssertFalse(viewModel.error)
                        deathInfosErrorExpectation.fulfill()
                    }
                }.store(in: &self.subscription)
                viewModel.load()
            }
        }.store(in: &subscription)
        waitForExpectations(timeout: 15, handler: nil)
    }
}
