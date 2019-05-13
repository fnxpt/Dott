//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

public struct VenueLocation: Decodable {
	public var address: String?
	public var latitude: Double
	public var longitude: Double

	private enum JSONKeys: String, CodingKey {
		case address = "formattedAddress"
		case latitude = "lat"
		case longitude = "lng"

	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: JSONKeys.self)

		let formattedAddress = try? container.decode([String].self, forKey: .address)

		address = formattedAddress?.joined(separator: "\n")
		latitude = try container.decode(Double.self, forKey: .latitude)
		longitude = try container.decode(Double.self, forKey: .longitude)
	}
}
