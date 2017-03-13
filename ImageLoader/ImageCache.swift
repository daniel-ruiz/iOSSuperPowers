//
//  ImageCache.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

/// Represents a cache of images
public protocol ImageCache: class {

	/// Returns the image associated with a given URL
	func image(for url: URL) -> UIImage?

	/// Sets the image of the specified URL in the cache.
	func setImage(_ image: UIImage, for url: URL)
}
