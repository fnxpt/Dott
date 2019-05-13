//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

protocol FoursquareRequest: Requestable {}

extension FoursquareRequest {
	internal static func request<Type>(path service: String,
	                                   parameters: [String: Any]?,
	                                   completionHandler: @escaping (Response<Type>) -> Void) where Type: Decodable {
		var queryParams: [String: Any] = parameters ?? [:]

		queryParams["client_id"] = API.client
		queryParams["client_secret"] = API.secret
		queryParams["v"] = API.version

		let queryString = queryParams.compactMap { (key, value) -> String in
			"\(key)=\(value)"
		}

		var servicePath = service

		if !queryString.isEmpty {
			servicePath.append(contentsOf: "?" + queryString.joined(separator: "&"))
		}

		guard let endpoint = URL(string: API.endpoint),
			let path = URL(string: servicePath, relativeTo: endpoint) else {
			completionHandler(.error(error: ServiceError.unexpected))
			return
		}

		let session = URLSession.shared
		var request = URLRequest(url: path)
		request.httpMethod = API.method
		request.allHTTPHeaderFields = ["Content-Type": "application/json; chartset=utf-8"]

		let task = session.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.error(error: error))
			} else if let data = data,
				let response = response as? HTTPURLResponse {
				do {
					if response.statusCode == 200 {

						let operation = try Operation<Type>.decode(data: data)
						completionHandler(.success(object: operation.response.objects))
					} else {
						completionHandler(.error(error: ServiceError.unexpected))
					}
				} catch let decodeError {
					completionHandler(.error(error: decodeError))
				}
			} else {
				completionHandler(.error(error: ServiceError.unexpected))
			}
		}

		task.resume()
	}
}
