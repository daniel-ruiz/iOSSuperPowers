//
//  VolumeViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

/// A comic volume as it is displayed in the screen
struct VolumeViewModel {

	/// Unique identifier
	let identifier: Int64

	/// Volume title
	let title: String

	/// Cover image URL
	let coverURL: URL?

	/// Publisher name
	let publisherName: String?
}
