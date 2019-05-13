//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

extension Decodable {
	static func decode(data: Data) throws -> Self {
		let decoder = JSONDecoder()
		return try decoder.decode(Self.self, from: data)
	}
}
