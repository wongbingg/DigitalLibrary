//
//  DigitalLibraryTests.swift
//  DigitalLibraryTests
//
//  Created by 이원빈 on 2023/05/06.
//

import XCTest
@testable import DigitalLibrary

final class DigitalLibraryTests: XCTestCase {
    var sut: BookAPI!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BookAPI(offset: "0")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_API가_정상적으로_작동하는지() async throws {
        // given
        let expectation = "조회되었습니다."
        
        // when
        let response = try await sut.execute()
        
        // then
        XCTAssertEqual(expectation, response.message)
    }
}
