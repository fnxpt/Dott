//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

public struct VenuePhotos: Decodable {
	public var photos: [(String, String)]?

	private enum JSONKeys: String, CodingKey {
		case groups
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: JSONKeys.self)

		//        let groups = try? container.decode([[String: Any]].self, forKey: .groups)

	}
}
