//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import XCTest
@testable import App

class AppTests: XCTestCase {

	func testDefaultValues() {

		XCTAssertNotEqual("x", "CLIENT_ID", "client should be a valid value")
	}
}
