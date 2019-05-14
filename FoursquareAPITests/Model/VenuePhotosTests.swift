//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import XCTest
@testable import FoursquareAPI

class VenuePhotosTests: XCTestCase {

	func testWithValidFile() {
		let data = load(file: "venue_photos", extension: "json")

		XCTAssertNotNil(data)
		let item = try? VenuePhotos.decode(data: data!)
		XCTAssertNotNil(item)

		XCTAssertEqual(item!.count, 22)
		XCTAssertNotNil(item!.groups)

		let urls = item?.photos(with: CGSize(width: 200, height: 200))
		XCTAssertEqual(urls?.count, 6)

		XCTAssertEqual(urls?.first?.absoluteString, "https://fastly.4sqi.net/img/general/200x200/466741635_4yn5AUmtUS5_XqEkkF-ceTLYneEv3Qn3tclhIgz3xjs.jpg")
	}

	func testInvalidFile() {
		let data = load(file: "x", extension: "json")

		XCTAssertNil(data)
	}

	func testEmptyFile() {
		let data = load(file: "empty", extension: "json")

		XCTAssertNotNil(data)

		let item = try? VenuePhotos.decode(data: data!)
		XCTAssertNil(item)
	}
}
