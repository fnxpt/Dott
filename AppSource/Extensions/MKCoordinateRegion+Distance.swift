//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import MapKit

extension MKCoordinateRegion {
	func maxDistance() -> CLLocationDistance {
		let furthest = CLLocation(latitude: center.latitude + (span.latitudeDelta / 2),
		                          longitude: center.longitude + (span.longitudeDelta / 2))
		let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
		return centerLocation.distance(from: furthest)
	}
}
