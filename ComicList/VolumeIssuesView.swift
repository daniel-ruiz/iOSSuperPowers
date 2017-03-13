//
//  VolumeIssuesView.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

final class VolumeIssuesView: UIView {

	@IBOutlet private weak var titleLabel: UILabel! {
		didSet {
			titleLabel.text = NSLocalizedString("ISSUES", comment: "")
			titleLabel.textColor = UIColor(named: .darkText)
		}
	}

	@IBOutlet private(set) weak var collectionView: UICollectionView! {
		didSet {
			collectionView.backgroundColor = UIColor(named: .detailBackground)
			collectionView.register(VolumeCell.self)
		}
	}
}
