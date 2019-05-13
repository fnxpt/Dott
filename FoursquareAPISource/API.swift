//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

struct API {
	static let endpoint = "https://api.foursquare.com/v2/"
	static let method = "GET"
	static let version = "20180323"
	static let client = "CLIENT_ID"
	static let secret = "CLIENT_SECRET"

	enum Venues: String {
		case search = "venues/search"
		case detail = "venues/%s"
	}
}
