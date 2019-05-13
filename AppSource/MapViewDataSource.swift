//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import MapKit

protocol MapViewDataSourceDelegate: AnyObject {
	func didUpdateItems()
	func didSelect(item: MKAnnotation)
	func didFail(with error: Error)
}

class MapViewDataSource: NSObject {
	var items: Set = Set<Venue>()
	weak var delegate: MapViewDataSourceDelegate?
}

extension MapViewDataSource: MKMapViewDelegate {

	func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered _: Bool) {
		DispatchQueue(label: "venues", qos: .background).async {
			VenuesRequest.getVenues(in: mapView.region.center, radius: Int(mapView.region.maxDistance())) { [weak self] result in
				switch result {
				case let .success(objects):
					objects.forEach { self?.items.insert($0) }
					self?.delegate?.didUpdateItems()
				case let .error(error):
					self?.delegate?.didFail(with: error)
				}
			}
		}
	}

	func mapView(_: MKMapView, didSelect view: MKAnnotationView) {
		guard let annotation = view.annotation else { return }
		delegate?.didSelect(item: annotation)
	}
}
