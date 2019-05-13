//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

public struct VenueDetailRequest: FoursquareRequest {
	public typealias `Type` = Venue
	static var service: String = API.Venues.detail.rawValue

	public static func getVenueDetail(_ identifier: String, completionHandler: @escaping (Response<Type>) -> Void) {

		request(path: String(format: service, identifier), parameters: nil, completionHandler: completionHandler)
	}
}
