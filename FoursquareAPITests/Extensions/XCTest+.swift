//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import XCTest

extension XCTest {

	func load(file: String, extension ext: String, bundle: Bundle = Bundle(for: APITests.self)) -> Data? {
		guard let url = bundle.url(forResource: file, withExtension: ext) else { return nil }
		return try? Data(contentsOf: url)
	}
}
