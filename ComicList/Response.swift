//
//  Response.swift
//  ComicList
//
//  Created by Guille Gonzalez on 11/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

struct Response<T: JSONDecodable> {

	let status: Int
	let message: String
	let results: [T]
}

extension Response: JSONDecodable {
	init(jsonDictionary: JSONDictionary) throws {
		status = try unpack(from: jsonDictionary, key: "status_code")
		message = try unpack(from: jsonDictionary, key: "error")

		if let value: T = try? unpackModel(from: jsonDictionary, key: "results") {
			results = [value]
		} else {
			results = try unpackModels(from: jsonDictionary, key: "results")
		}
	}
}
