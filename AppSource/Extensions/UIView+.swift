//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import UIKit

extension UIView {
	static func loadNibForClass<T: UIView>(bundle: Bundle = .main) -> T? {
		return bundle.loadNibNamed(String(describing: self), owner: self, options: nil)?.first as? T
	}
}

extension UIView {
	enum Anchors {
		case left
		case top
		case right
		case bottom
	}

	/// Sets the left, right, top and bottom anchor, so the view fits it's container.
	/// - parameter container: The container for which this view will be a child of.
	/// - parameter anchors: The anchors that should be activated for the container.
	/// - parameter margins: The margins around view.
	func fill(in container: UIView,
	          anchors: [Anchors] = [.left, .top, .right, .bottom],
	          margins: UIEdgeInsets = UIEdgeInsets.zero) {
		translatesAutoresizingMaskIntoConstraints = false
		for anchor in anchors {
			switch anchor {
			case .left:
				leftAnchor.constraint(equalTo: container.leftAnchor, constant: margins.left).isActive = true
			case .top:
				topAnchor.constraint(equalTo: container.topAnchor, constant: margins.top).isActive = true
			case .right:
				rightAnchor.constraint(equalTo: container.rightAnchor, constant: margins.right).isActive = true
			case .bottom:
				bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: margins.bottom).isActive = true
			}
		}
		setNeedsUpdateConstraints()
	}
}
