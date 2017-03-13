//
//  SearchResultsViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 09/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift
import Networking

extension VolumeViewModel {

	init(volume: Volume) {
		identifier = volume.identifier
		title = volume.title
		coverURL = volume.coverURL
		publisherName = nil
	}
}

final class SearchResultsViewModel {

	let query: String
	var didLoadPage: () -> Void = {}

	public var numberOfItems: Int {
		return items.count
	}

	public func item(at position: Int) -> VolumeViewModel {
		precondition(position < numberOfItems)
		return items[position]
	}

	public func load(autoloadNextOn trigger: Observable<Void>) -> Observable<Int> {
		return doLoad(page: 1, nextPage: trigger)
	}

	private var items: [VolumeViewModel] = []
	private let webClient = WebClient()

	init(query: String) {
		self.query = query
	}

	private func doLoad(page pageNumber: Int, nextPage trigger: Observable<Void>) -> Observable<Int> {
		let r = Volume.search(with: query, page: pageNumber)

		return webClient.load(resource: r)
			.map { response in
				return response.results.map(VolumeViewModel.init(volume:))
			}
			.observeOn(MainScheduler.instance)
			.do(onNext: { viewModels in
				self.items.append(contentsOf: viewModels)
				self.didLoadPage()
			})
			.flatMap { _ -> Observable<Int> in


				return Observable.concat([
					Observable.just(pageNumber),
					Observable.never().takeUntil(trigger),
					self.doLoad(page: pageNumber + 1, nextPage: trigger)
				])
			}
	}
}
