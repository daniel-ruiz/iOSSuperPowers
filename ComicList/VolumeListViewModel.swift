//
//  VolumeListViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

// FIXME: This is a fake implementation

/// A view model for the user's comic list.
final class VolumeListViewModel {

	/// Called when volumes are inserted or removed
	var didUpdate: () -> Void = {}

	/// The number of volumes in the list
	var numberOfVolumes: Int {
		return items.count
	}

	/// Returns the volume at a given position
	func item(at position: Int) -> VolumeViewModel {
		return items[position]
	}

	private let items: [VolumeViewModel] = [
		VolumeViewModel(identifier: 38656,
						title: "Doctor Strange: The Oath",
						coverURL: URL(string: "http://comicvine.gamespot.com/api/image/scale_small/1641291-ds__to.jpg"),
						publisherName: "Marvel"),
		VolumeViewModel(identifier: 67079,
						title: "Age Of Ultron",
						coverURL: URL(string: "http://comicvine.gamespot.com/api/image/scale_small/3816330-01.jpg"),
						publisherName: "Marvel"),
		VolumeViewModel(identifier: 39255,
						title: "Thanos Imperative",
						coverURL: URL(string: "http://comicvine.gamespot.com/api/image/scale_small/1704425-the_thanos_imperative_hc.jpg"),
						publisherName: "Marvel")
	]
}
