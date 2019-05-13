//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import FoursquareAPI
import UIKit

class DetailView: UIView {
	typealias ModelType = Venue

	@IBOutlet private var titleLabel: UILabel?
	@IBOutlet private var addressLabel: UILabel?
	@IBOutlet private var containerView: UIView?

	override func awakeFromNib() {
		super.awakeFromNib()
		theme()
	}
}

extension DetailView: Updatable {
	func update(with model: ModelType) {
		titleLabel?.text = model.name
		addressLabel?.text = model.location.address
	}
}

extension DetailView: Themable {
	func theme() {
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		addressLabel?.font = UIFont.preferredFont(forTextStyle: .callout)

		containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		layer.cornerRadius = 8
		layer.masksToBounds = false
	}
}
