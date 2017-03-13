//
//  ImageLoader.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit
import RxSwift

import Networking

/// Loads remote images, storing them in a memory cache
public final class ImageLoader {

	public static let shared = ImageLoader(cache: MemoryImageCache(), client: WebClient())

	init(cache: ImageCache, client: WebClient) {
		self.cache = cache
		self.client = client
	}

	public func image(for url: URL) -> Observable<UIImage?> {
		// If the image is already in the cache, just return it
		if let image = cache.image(for: url) {
			return Observable.just(image)
		}

		// Otherwise, we have to fetch the data for the corresponding URL
		let resource = Resource(url: url) { data -> UIImage? in
			UIImage(data: data)
		}

		return client.load(resource: resource)
			// Store the image in the cache
			.do(onNext: { image in
				if let image = image {
					self.cache.setImage(image, for: url)
				}
			})
			// Return `nil` on error
			.catchErrorJustReturn(nil)
			// Make sure the image is delivered in the main thread
			.observeOn(MainScheduler.instance)
	}

	// MARK: - Private

	private let cache: ImageCache
	private let client: WebClient
}
