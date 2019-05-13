//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

protocol Updatable {
	associatedtype ModelType: Any
	func update(with model: ModelType)
}
