//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import MapKit

protocol MapViewDataSourceDelegate: AnyObject {
	func didUpdateItems(_ newItems: [MKAnnotation])
	func didSelect(item: MKAnnotation?)
	func didFail(with error: Error)
}

class MapViewDataSource: NSObject {
	var items: Set = Set<Venue>()
	weak var delegate: MapViewDataSourceDelegate?
}

extension MapViewDataSource: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, regionDidChangeAnimated _: Bool) {
		DispatchQueue(label: "venues", qos: .background).async {
			VenuesRequest.getVenues(in: mapView.region.center, radius: Int(mapView.region.maxDistance())) { [weak self] result in
				switch result {
				case let .success(objects):
					guard let items = self?.items else { return }
					let uniqueObjects = Set(objects).subtracting(items)
					uniqueObjects.forEach { self?.items.insert($0) }
					self?.delegate?.didUpdateItems(Array(uniqueObjects))
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

	func mapView(_: MKMapView, didDeselect _: MKAnnotationView) {
		delegate?.didSelect(item: nil)
	}
}
