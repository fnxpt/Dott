//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import XCTest
@testable import FoursquareAPI

class VenueTests: XCTestCase {

	func testWithValidFile() {

		let data = load(file: "venue", extension: "json")

		XCTAssertNotNil(data)
		let item = try? Venue.decode(data: data!)
		XCTAssertNotNil(item)

		XCTAssertEqual("", "")
	}

	func testInvalidFile() {
		let data = load(file: "x", extension: "json")

		XCTAssertNil(data)
	}

	func testEmptyFile() {
		let data = load(file: "empty", extension: "json")

		XCTAssertNotNil(data)
		let item = try? Venue.decode(data: data!)
		XCTAssertNil(item)
	}
}
