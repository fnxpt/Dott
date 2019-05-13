//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import MapKit

extension Venue: MKAnnotation {
	public var coordinate: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
	}
}
