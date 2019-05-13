//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import MapKit
import UIKit

public enum ApplicationError: Error {
	case error(message: String)
}

class MapViewController: UIViewController {

	@IBOutlet private var mapView: MKMapView?
	lazy var locationManager = CLLocationManager()
	let dataSource = MapViewDataSource()

	lazy var detailView: DetailView? = {
		guard let view = DetailView.loadNibForClass() as? DetailView else { return nil }
		view.isHidden = true
		addView(view)
		return view
	}()

	lazy var errorView: ErrorView? = {
		guard let view = ErrorView.loadNibForClass() as? ErrorView else { return nil }
		view.isHidden = true
		addView(view)
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		if let mapView = mapView {
			dataSource.delegate = self
			mapView.delegate = dataSource
			let distance: CLLocationDistance = 5000
			let region = MKCoordinateRegion(center: mapView.region.center, latitudinalMeters: distance, longitudinalMeters: distance)
			mapView.setRegion(region, animated: false)
		}

		handleAuthorization()
	}

	func displayError(error: Error) {
		errorView?.update(with: error)
		DispatchQueue.main.async { [weak self] in
			self?.errorView?.isHidden = false
			self?.detailView?.isHidden = true
		}

	}

	func displayDetail(venue: Venue) {
		VenueDetailRequest.getVenueDetail(venue.identifier) { [weak self] _ in
			self?.detailView?.update(with: venue)
		}
		detailView?.update(with: venue)
		DispatchQueue.main.async { [weak self] in
			self?.detailView?.isHidden = false
			self?.errorView?.isHidden = true
		}
	}

	func handleAuthorization() {
		switch CLLocationManager.authorizationStatus() {
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		case .denied, .restricted:
			let error = ApplicationError.error(message: "Unable to get location")
			displayError(error: error)
		default:
			break
		}
	}

	func addView(_ auxView: UIView) {
		DispatchQueue.main.async { [weak self] in
			guard let view = self?.view else { return }

			view.addSubview(auxView)
			let margin: CGFloat = 16
			let insets = UIEdgeInsets(top: 0, left: margin, bottom: -(margin + view.safeAreaInsets.bottom), right: -margin)
			auxView.fill(in: view, anchors: [.left, .right, .bottom], margins: insets)
			view.bringSubviewToFront(auxView)
		}
	}
}

extension MapViewController: MapViewDataSourceDelegate {
	func didFail(with error: Error) {
		displayError(error: error)
	}

	func didSelect(item: MKAnnotation) {
		guard let item = item as? Venue else { return }
		displayDetail(venue: item)
	}

	func didUpdateItems() {
		DispatchQueue.main.async { [weak self] in
			guard let mapView = self?.mapView,
				let dataSource = self?.dataSource else { return }

			mapView.removeAnnotations(mapView.annotations)
			mapView.addAnnotations(Array(dataSource.items))
		}
	}
}
