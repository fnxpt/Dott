//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

public extension String {
	func localize() -> String {
		return NSLocalizedString(self, comment: "")
	}
}
