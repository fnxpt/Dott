//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

extension Decodable {
	static func decode(data: Data) throws -> Self {
		let decoder = JSONDecoder()
		return try decoder.decode(Self.self, from: data)
	}

	static func decode(data: Data, keyPath: String?) throws -> Self {
		guard let keyPath = keyPath else { return try decode(data: data) }

		let toplevel = try JSONSerialization.jsonObject(with: data)
		if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
			let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
			return try decode(data: nestedJsonData)
		} else {
			throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Nested json not found for key path \"\(keyPath)\""))
		}
	}
}
