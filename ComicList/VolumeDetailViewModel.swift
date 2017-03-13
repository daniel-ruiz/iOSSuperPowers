//
//  VolumeDetailViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

import Networking

// FIXME: This is a fake implementation

final class VolumeDetailViewModel {

	/// Determines if the volume is saved in the user's comic list
	var isSaved: Observable<Bool> {
		return Observable.just(true)
	}

	/// The volume information
	private(set) var volume: VolumeViewModel

	private let webClient = WebClient()

	/// The volume description
	private(set) lazy var about: Observable<String?> = self.webClient
		.load(resource: Volume.detail(withIdentifier: self.volume.identifier))
		.map { $0.results[0].description }
		.map { description in
			return description?.replacingOccurrences(
				of: "<[^>]+>",
				with: "",
				options: .regularExpression,
				range: nil
			)
		}
		.startWith(nil)
		// This could be done automatically using a Driver instead of an Observable
		.observeOn(MainScheduler.instance)
		.shareReplay(1)

	/// The issues for this volume
    private(set) lazy var issues: Observable<[IssueViewModel]> = self.webClient
        .load(resource: Volume.issues(forVolumeIdentifier: self.volume.identifier))
        .map { $0.results.map { IssueViewModel(title: $0.title, coverURL: $0.coverURL) }  }
        .observeOn(MainScheduler.instance)

	/// Adds or removes the volume from the user's comic list
	func addOrRemove(){
		// TODO: implement
	}

	init(volume: VolumeViewModel) {
		self.volume = volume
	}
}
