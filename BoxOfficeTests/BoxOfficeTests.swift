//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by rae on 2023/01/22.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_dailyButtonDidTap() {
        let reactor = MovieListReactor()
        reactor.action.onNext(.dailyButtonDidTap)
        XCTAssertEqual(reactor.currentState.buttonDidSelected, .daily)
    }

}
