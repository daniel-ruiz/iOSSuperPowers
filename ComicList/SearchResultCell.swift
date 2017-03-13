//
//  SearchResultCell.swift
//  ComicList
//
//  Created by Guille Gonzalez on 09/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell, NibLoadableView {

	@IBOutlet weak var coverView: CoverView!

	@IBOutlet weak var titleLabel: UILabel! {
		didSet {
			titleLabel.textColor = UIColor(named: .darkText)
		}
	}

	@IBOutlet weak var publisherLabel: UILabel! {
		didSet {
			publisherLabel.textColor = UIColor(named: .lightText)
		}
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		// This will cancel any pending image download
		coverView.url = nil
	}
}
