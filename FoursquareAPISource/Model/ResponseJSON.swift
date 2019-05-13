//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

struct ResponseJSON<Type>: Decodable where Type: Decodable {
	public var objects: Type

	private enum JSONKeys: String, CodingKey {
		case objects = "venues"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: JSONKeys.self)

		objects = try container.decode(Type.self, forKey: .objects)
	}
}
