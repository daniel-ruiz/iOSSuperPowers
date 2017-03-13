//
//  SuggestionsCoordinator.swift
//  ComicList
//
//  Created by Guille Gonzalez on 08/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

/// Coordinates the presentation of the search UI
final class SuggestionsCoordinator: Coordinator {

	private unowned let navigationItem: UINavigationItem
	private unowned let navigationController: UINavigationController
	private var searchController: UISearchController!

	init(navigationItem: UINavigationItem, navigationController: UINavigationController) {
		self.navigationItem = navigationItem
		self.navigationController = navigationController
	}

	override func start() {
		searchController = setupSearchController()
		navigationItem.titleView = searchController.searchBar
	}

	private func setupSearchController() -> UISearchController {
		let viewModel = SuggestionsViewModel()
		let viewController = SuggestionsViewController(viewModel: viewModel)
		let searchController = UISearchController(searchResultsController: viewController)

		viewController.didSelectSuggestion = { [weak self] suggestion in
			self?.presentSearchResults(for: suggestion)
		}

		searchController.searchResultsUpdater = viewController
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.searchBar.delegate = self

		searchController.searchBar.placeholder = NSLocalizedString("Search Comic Vine", comment: "")
		searchController.searchBar.searchBarStyle = .minimal
		searchController.searchBar.searchFieldTextColor = UIColor.white
		searchController.searchBar.keyboardAppearance = .dark

		return searchController
	}

	fileprivate func presentSearchResults(for query: String) {
		let coordinator = SearchResultsCoordinator(query: query, navigationController: navigationController)

		add(child: coordinator)
		coordinator.start()
	}
}

extension SuggestionsCoordinator: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let text = searchBar.text ?? ""

		if !text.isEmpty {
			presentSearchResults(for: text)
		}
	}
}
