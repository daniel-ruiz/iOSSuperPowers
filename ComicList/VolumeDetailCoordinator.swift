//
//  VolumeDetailCoordinator.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

/// Coordinates the presentation of a volume detail
final class VolumeDetailCoordinator: Coordinator {

	init(volume: VolumeViewModel, navigationController: UINavigationController) {
		self.volume = volume
		self.navigationController = navigationController
	}

	override func start() {
		let viewModel = VolumeDetailViewModel(volume: volume)
		let viewController = VolumeDetailViewController(viewModel: viewModel)

		viewController.didFinish = {
			self.done()
		}


		
		viewController.didFinish = { [weak self] in
			guard let `self` = self else {
				return
			}

			// This will remove the coordinator from its parent
			self.done()
		}

		navigationController.pushViewController(viewController, animated: true)
	}

	// MARK: - Private

	private let volume: VolumeViewModel
	private unowned let navigationController: UINavigationController
}
