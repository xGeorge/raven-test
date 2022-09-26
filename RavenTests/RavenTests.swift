//
//  RavenTests.swift
//  RavenTests
//
//  Created by Jorge Torres on 23/09/22.
//

import XCTest
@testable import Raven

class RavenTests: XCTestCase {

    static var globalDate: Date!

    static override func setUp() {
        globalDate = "2020-09-25T19:38:18.000Z".convertDate()!
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFixedDateFormat1() throws {
        let result = RavenTests.globalDate - "2020-09-25T19:38:18.000Z".convertDate()!
        XCTAssertEqual(result.second!, 0)
        XCTAssertEqual(result.minute!, 0)
        XCTAssertEqual(result.hour!, 0)
        XCTAssertEqual(result.day!, 0)
        XCTAssertEqual(result.month!, 0)
    }

    func testFixedDateFormat2() throws {
        let result = RavenTests.globalDate - "2020-09-25T19:38:17.000Z".convertDate()!
        XCTAssertEqual(result.second!, 1)
        XCTAssertEqual(result.minute!, 0)
        XCTAssertEqual(result.hour!, 0)
        XCTAssertEqual(result.day!, 0)
        XCTAssertEqual(result.month!, 0)
    }

    func testFixedDateFormat3() throws {
        let result = RavenTests.globalDate - "2020-09-25T19:37:17.000Z".convertDate()!
        XCTAssertGreaterThan(result.second!, 0)
        XCTAssertEqual(result.minute!, 1)
        XCTAssertEqual(result.hour!, 0)
        XCTAssertEqual(result.day!, 0)
        XCTAssertEqual(result.month!, 0)
    }

    func testFixedDateFormat4() throws {
        let result = RavenTests.globalDate - "2020-09-25T18:38:18.000Z".convertDate()!
        XCTAssertGreaterThan(result.second!, 0)
        XCTAssertGreaterThan(result.minute!, 0)
        XCTAssertEqual(result.hour!, 1)
        XCTAssertEqual(result.day!, 0)
        XCTAssertEqual(result.month!, 0)
    }

    func testFixedDateFormat5() throws {
        let result = RavenTests.globalDate - "2020-09-24T18:38:18.000Z".convertDate()!
        XCTAssertGreaterThan(result.second!, 0)
        XCTAssertGreaterThan(result.minute!, 0)
        XCTAssertGreaterThan(result.hour!, 0)
        XCTAssertEqual(result.day!, 1)
        XCTAssertEqual(result.month!, 0)
    }

    func testFixedDateFormat6() throws {
        let result = RavenTests.globalDate - "2020-08-24T18:38:18.000Z".convertDate()!
        XCTAssertGreaterThan(result.second!, 0)
        XCTAssertGreaterThan(result.minute!, 0)
        XCTAssertGreaterThan(result.hour!, 0)
        XCTAssertGreaterThan(result.day!, 0)
        XCTAssertEqual(result.month!, 1)
    }
}
