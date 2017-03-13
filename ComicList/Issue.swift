//
//  Issue.swift
//  ComicList
//
//  Created by Daniel Ruiz on 13/03/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import Networking

struct Issue {
    let identifier: Int64
    let title: String
    let coverURL: URL?
}

extension Issue: JSONDecodable {
    init(jsonDictionary: JSONDictionary) throws {
        identifier = (try? unpack(from: jsonDictionary, key: "id")) ?? 0
        title = (try? unpack(from: jsonDictionary, key: "name")) ?? ""
        coverURL = try? unpack(from: jsonDictionary, keyPath: "image.small_url")
    }
}
