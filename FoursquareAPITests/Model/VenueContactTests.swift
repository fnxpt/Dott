//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import XCTest
@testable import FoursquareAPI

class VenueContactTests: XCTestCase {

	func testWithValidFile() {
		let data = load(file: "venue_contact", extension: "json")

		XCTAssertNotNil(data)
		let item = try? VenueContact.decode(data: data!)
		XCTAssertNotNil(item)

		XCTAssertEqual(item!.phone, "+79101597279")
		XCTAssertNil(item!.twitter)
		XCTAssertEqual(item!.instagram, "lepimvarimtula")
		XCTAssertEqual(item!.facebook, "155369921719144")
	}

	func testInvalidFile() {
		let data = load(file: "x", extension: "json")

		XCTAssertNil(data)
	}

	func testEmptyFile() {
		let data = load(file: "empty", extension: "json")

		XCTAssertNotNil(data)

		let item = try? VenueContact.decode(data: data!)
		XCTAssertNotNil(item)

		XCTAssertNil(item!.phone)
		XCTAssertNil(item!.twitter)
		XCTAssertNil(item!.instagram)
		XCTAssertNil(item!.facebook)
	}
}
