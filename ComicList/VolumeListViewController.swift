//
//  VolumeListViewController.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

class VolumeListViewController: UIViewController {

	// MARK: - Properties

	@IBOutlet private weak var collectionView: UICollectionView! {
		didSet {
			collectionView.register(VolumeCell.self)
			collectionView.backgroundColor = UIColor(named: .background)
		}
	}

	/// Called when the user selects a volume
	var didSelectVolume: (VolumeViewModel) -> Void = { _ in }

	/// The view model
	fileprivate let viewModel: VolumeListViewModel

	// MARK: - Initialization

	init(viewModel: VolumeListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		// We need to reload our collection view when the
		// comic list is updated
		viewModel.didUpdate = collectionView.reloadData
	}
}

// MARK: - UICollectionViewDataSource

extension VolumeListViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfVolumes
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let volume = viewModel.item(at: indexPath.item)
		let cell: VolumeCell = collectionView.dequeueReusableCell(for: indexPath)

		cell.coverView.url = volume.coverURL
		cell.titleLabel.text = volume.title

		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension VolumeListViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let volume = viewModel.item(at: indexPath.item)
		didSelectVolume(volume)
	}
}
