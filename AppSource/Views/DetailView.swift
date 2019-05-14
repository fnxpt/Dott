//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import Kingfisher
import UIKit

class DetailView: UIView, OverlayView {
	typealias ModelType = Venue

	@IBOutlet private var titleLabel: UILabel?
	@IBOutlet private var addressLabel: UILabel?
	@IBOutlet private var phoneButton: UIButton?
	@IBOutlet private var containerView: UIView?
	@IBOutlet private var imageView: UIImageView?
	var timer: Timer?
	weak var item: ModelType?

	override func awakeFromNib() {
		super.awakeFromNib()
		theme()
	}

	@IBAction func makeCall(_: Any) {
		guard let phone = item?.contact?.phone,
			let url = URL(string: "tel://\(phone)"),
			UIApplication.shared.canOpenURL(url) else { return }
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
}

extension DetailView: Updatable {
	func update(with model: ModelType) {
		VenueDetailRequest.getVenueDetail(model.identifier) { [weak self] result in
			switch result {
			case let .success(object):
				DispatchQueue.main.async { [weak self] in
					self?.titleLabel?.text = object.name
					self?.addressLabel?.text = object.location.address

					guard let imageView = self?.imageView else { return }
					let url = object.photos?.photos(with: imageView.bounds.size).first
					imageView.kf.setImage(with: url)
					let hasPhone = !(object.contact?.phone?.isEmpty ?? true)
					self?.phoneButton?.isHidden = !hasPhone
					self?.item = object
				}
			default:
				break
			}
		}
	}
}

extension DetailView: Themable {
	func theme() {
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		addressLabel?.font = UIFont.preferredFont(forTextStyle: .callout)

		titleLabel?.textColor = .white
		addressLabel?.textColor = .white
		containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		layer.cornerRadius = 8
		layer.masksToBounds = false

		imageView?.contentMode = .scaleAspectFill
	}
}
