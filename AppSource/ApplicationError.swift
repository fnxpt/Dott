//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

struct ApplicationError: Error {
	let message: String

	var localizedDescription: String {
		return message
	}
}
