//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import Foundation

public enum ServiceError: Error {
	case unexpected
	case error(message: String)
}

extension ServiceError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .unexpected:
			return "Unexpected behaviour"
		case let .error(reason):
			return reason
		}
	}
}

public enum Response<Type> {
	case error(error: Error)
	case success(object: Type)
}

protocol Requestable {
	static var service: String { get }

	static func request<Type: Decodable>(path service: String,
	                                     keyPath: String?,
	                                     parameters: [String: Any]?,
	                                     completionHandler: @escaping (Response<Type>) -> Void)
}
