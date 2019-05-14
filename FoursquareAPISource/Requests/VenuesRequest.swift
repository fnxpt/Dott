//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import CoreLocation
import Foundation

public struct VenuesRequest: FoursquareRequest {
	public typealias `Type` = Venue
	static var service: String = API.Venues.search.rawValue
	private static let restaurantCategory = "4d4b7105d754a06374d81259"

	public static func getVenues(in coordinate: CLLocationCoordinate2D, radius: Int = 250, limit: Int = 50,
	                             completionHandler: @escaping (Response<[Type]>) -> Void) {

		let parameters: [String: Any] = [
			"ll": "\(coordinate.latitude),\(coordinate.longitude)",
			"radius": "\(radius)",
			"categoryId": restaurantCategory,
			"limit": "\(limit)"
		]

		request(path: service, keyPath: "response.venues", parameters: parameters, completionHandler: completionHandler)
	}
}
