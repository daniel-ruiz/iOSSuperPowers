//
//  VolumeListCoordinator.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

/// Coordinates all the navigation originating from the comic list screen
final class VolumeListCoordinator: Coordinator {

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	override func start() {
		let viewController = setupViewController()
		let suggestionsCoordinator = SuggestionsCoordinator(
			navigationItem: viewController.navigationItem,
			navigationController: navigationController
		)

		add(child: suggestionsCoordinator)
		suggestionsCoordinator.start()

		navigationController.pushViewController(viewController, animated: false)
	}

	// MARK: - Private

	private unowned let navigationController: UINavigationController

	private func setupViewController() -> UIViewController {
		let viewController = VolumeListViewController(viewModel: VolumeListViewModel())

		viewController.didSelectVolume = { [weak self] volume in
			self?.presentDetail(for: volume)
		}

		viewController.definesPresentationContext = true
		return viewController
	}

	private func presentDetail(for volume: VolumeViewModel) {
		let coordinator = VolumeDetailCoordinator(volume: volume, navigationController: navigationController)
		add(child: coordinator)

		coordinator.start()
	}
}
