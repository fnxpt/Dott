//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import UIKit

class ErrorView: UIView, OverlayView {
	typealias ModelType = Error

	@IBOutlet private var titleLabel: UILabel?
	@IBOutlet private var messageLabel: UILabel?
	var timer: Timer?

	override func awakeFromNib() {
		super.awakeFromNib()
		theme()
	}
}

extension ErrorView: Updatable {

	func update(with model: ModelType) {
		DispatchQueue.main.async { [weak self] in
			self?.titleLabel?.text = "generic_error".localize()
			self?.messageLabel?.text = model.localizedDescription
		}
	}
}

extension ErrorView: Themable {
	func theme() {
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		messageLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)

		backgroundColor = UIColor.red.withAlphaComponent(0.5)
		layer.cornerRadius = 8
		layer.masksToBounds = false

		titleLabel?.textColor = .darkText
		messageLabel?.textColor = .darkText
	}
}
