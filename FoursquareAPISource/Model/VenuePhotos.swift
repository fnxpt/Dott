//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import CoreGraphics
import Foundation

public struct VenuePhotos: Decodable {

	var count: Int
	var groups: [VenuePhotosGroup]?
	public func photos(with size: CGSize) -> [URL] {
		var urls: [URL] = []
		groups?.forEach {
			$0.items?.forEach {
				guard let url = $0.url(size: size) else { return }
				urls.append(url)
			}
		}
		return urls
	}
}

struct VenuePhotosGroup: Decodable {

	var count: Int
	var items: [VenuePhotosGroupItem]?
}

struct VenuePhotosGroupItem: Decodable {

	var prefix: String?
	var suffix: String?

	func url(size: CGSize) -> URL? {
		guard let prefix = prefix, let suffix = suffix else { return nil }
		let sizeString = "\(Int(size.width))x\(Int(size.height))"
		let urlString = "\(prefix)\(sizeString)\(suffix)"
		return URL(string: urlString)
	}
}
