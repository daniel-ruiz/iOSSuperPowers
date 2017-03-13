//
//  VolumeCell.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

class VolumeCell: UICollectionViewCell, ReusableView, NibLoadableView {

	@IBOutlet weak var coverView: CoverView!
	@IBOutlet weak var titleLabel: UILabel!

	override func prepareForReuse() {
		super.prepareForReuse()

		// This will cancel any pending image download
		coverView.url = nil
	}
}
