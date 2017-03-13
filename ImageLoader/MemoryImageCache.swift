//
//  MemoryImageCache.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

/// A simple memory cache for images
internal final class MemoryImageCache: ImageCache {

	// NSCache is thread-safe
	// NSURL is used instead of URL as the key because
	// NSCache requires AnyObject, and URL is a value type
	private let cache = NSCache<NSURL, UIImage>()

	internal func image(for url: URL) -> UIImage? {
		return cache.object(forKey: url as NSURL)
	}

	internal func setImage(_ image: UIImage, for url: URL) {
		cache.setObject(image, forKey: url as NSURL)
	}
}
