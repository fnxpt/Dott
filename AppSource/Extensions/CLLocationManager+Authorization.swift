//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import CoreLocation

extension CLLocationManager {
	func checkAndRequestAuthorization() -> Error? {
		switch CLLocationManager.authorizationStatus() {
		case .notDetermined:
			requestWhenInUseAuthorization()
		case .denied, .restricted:
			return ApplicationError(message: "permission_denied".localize())
		default:
			break
		}
		return nil
	}
}
