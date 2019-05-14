//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import XCTest
@testable import FoursquareAPI

class APITests: XCTestCase {

	func testDefaultValues() {
		XCTAssertNotEqual(API.client, "CLIENT_ID", "client should be a valid value")
		XCTAssertNotEqual(API.secret, "CLIENT_SECRET", "secret should be a valid value")
	}
}
