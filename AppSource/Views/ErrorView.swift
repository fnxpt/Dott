//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import UIKit

class ErrorView: UIView {
	typealias ModelType = Error
	@IBOutlet private var titleLabel: UILabel?
	@IBOutlet private var messageLabel: UILabel?

	override func awakeFromNib() {
		super.awakeFromNib()
		theme()
	}
}

extension ErrorView: Updatable {

	func update(with model: ModelType) {
		titleLabel?.text = "Error"
		messageLabel?.text = model.localizedDescription
	}
}

extension ErrorView: Themable {
	func theme() {
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		messageLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)

		backgroundColor = UIColor.red.withAlphaComponent(0.3)
		layer.cornerRadius = 8
		layer.masksToBounds = false
	}
}
