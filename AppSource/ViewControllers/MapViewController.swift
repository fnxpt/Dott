//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import MapKit
import UIKit

class MapViewController: UIViewController {

	@IBOutlet private var mapView: MKMapView?
	lazy var locationManager = CLLocationManager()
	let dataSource = MapViewDataSource()

	var overlayView: OverlayView?

	override func viewDidLoad() {
		super.viewDidLoad()

		if let mapView = mapView {
			dataSource.delegate = self
			mapView.delegate = dataSource
			let distance: CLLocationDistance = 5000
			let region = MKCoordinateRegion(center: mapView.region.center, latitudinalMeters: distance, longitudinalMeters: distance)
			mapView.setRegion(region, animated: false)
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		if let error = locationManager.checkAndRequestAuthorization() {
			toggleView(type: ErrorView.self, object: error, interval: 5)
		}
	}

	func toggleView(type: UIView.Type, object: Any, interval: TimeInterval = 0) {
		guard let view = type.loadNibForClass() as? OverlayView else { return }

		// TODO: THIS CAN BE IMPROVED
		if let view = view as? ErrorView,
			let object = object as? Error {
			view.update(with: object)
		} else if let view = view as? DetailView,
			let object = object as? Venue {
			view.update(with: object)
		}

		view.show(in: self.view, margin: 16, during: interval)
		overlayView = view
	}
}

extension MapViewController: MapViewDataSourceDelegate {
	func didFail(with error: Error) {
		toggleView(type: ErrorView.self, object: error, interval: 10)
	}

	func didSelect(item: MKAnnotation?) {
		guard let item = item as? Venue else {
			overlayView?.hide()
			return
		}
		toggleView(type: DetailView.self, object: item)
	}

	func didUpdateItems(_ newItems: [MKAnnotation]) {
		DispatchQueue.main.async { [weak self] in
			guard let mapView = self?.mapView else { return }

			mapView.addAnnotations(newItems)
		}
	}
}
