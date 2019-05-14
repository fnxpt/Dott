//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import UIKit

protocol OverlayView {
	var timer: Timer? { get set }
	func show(in view: UIView, margin: CGFloat, during interval: TimeInterval)
	func hide()
}

extension OverlayView where Self: UIView {
	func show(in view: UIView, margin: CGFloat = 16, during interval: TimeInterval = 0) {
		DispatchQueue.main.async { [weak self] in
			guard var strongSelf = self else { return }
			if strongSelf.superview != self {
				strongSelf.isHidden = true
				view.addSubview(strongSelf)
				let insets = UIEdgeInsets(top: 0, left: margin, bottom: -(margin + view.safeAreaInsets.bottom), right: -margin)
				strongSelf.fill(in: view, anchors: [.left, .right, .bottom], margins: insets)
			}

			view.bringSubviewToFront(strongSelf)

			UIView.animate(withDuration: 0.25, animations: {
				strongSelf.isHidden = false
			}) { _ in
				if interval > 0 {
					strongSelf.timer = Timer(timeInterval: interval, repeats: false) { timer in
						strongSelf.hide()
						timer.invalidate()
						strongSelf.timer = nil
					}
					strongSelf.timer?.fire()
				}
			}
		}
	}

	func hide() {
		UIView.animate(withDuration: 0.25) {
			self.isHidden = true
		}
	}
}
