//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

struct Operation<Type>: Decodable where Type: Decodable {
	public var meta: Meta
	public var response: ResponseJSON<Type>
}
