//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

public class Venue: NSObject, Decodable {
	public var identifier: String
	public var name: String
	public var location: VenueLocation
	public var contact: VenueContact?
	public var photos: VenuePhotos?

	private enum JSONKeys: String, CodingKey {
		case identifier = "id"
		case name
		case location
		case contact
		case photos
	}

	public required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: JSONKeys.self)

		identifier = try container.decode(String.self, forKey: .identifier)
		name = try container.decode(String.self, forKey: .name)
		location = try container.decode(VenueLocation.self, forKey: .location)
		contact = try? container.decode(VenueContact.self, forKey: .contact)
		photos = try? container.decode(VenuePhotos.self, forKey: .photos)
	}

	public override func isEqual(_ object: Any?) -> Bool {
		guard let object = object as? Venue else { return false }
		return object.identifier == identifier
	}
}
