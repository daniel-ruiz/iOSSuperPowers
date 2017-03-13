//
//  Volume.swift
//  ComicList
//
//  Created by Guille Gonzalez on 11/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

struct Volume {
	let identifier: Int64
	let title: String
	let coverURL: URL?
	let description: String?
}

extension Volume: JSONDecodable {
	init(jsonDictionary: JSONDictionary) throws {
		identifier = (try? unpack(from: jsonDictionary, key: "id")) ?? 0
		title = try unpack(from: jsonDictionary, key: "name")
		coverURL = try? unpack(from: jsonDictionary, keyPath: "image.small_url")
		description = try? unpack(from: jsonDictionary, key: "description")
	}
}

extension Volume {

	public static func titles(with query: String) -> Resource<Response<Volume>> {
		return Resource(
			comicVinePath: "search",
			parameters: [
				"api_key": apiKey,
				"format": "json",
				"field_list": "name",
				"limit": "10",
				"page": "1",
				"query": query,
				"resources": "volume"
			]
		)
	}

	public static func search(with query: String, page: Int) -> Resource<Response<Volume>> {
		return Resource(
			comicVinePath: "search",
			parameters: [
				"api_key": apiKey,
				"format": "json",
				"field_list": "id,image,name",
				"limit": "20",
				"page": String(page),
				"query": query,
				"resources": "volume"
			]
		)
	}

	public static func detail(withIdentifier identifier: Int64) -> Resource<Response<Volume>> {
		return Resource(
			comicVinePath: "volume/4050-\(identifier)",
			parameters: [
				"api_key": apiKey,
				"format": "json",
				"field_list": "name,description",
			]
		)
	}
}
