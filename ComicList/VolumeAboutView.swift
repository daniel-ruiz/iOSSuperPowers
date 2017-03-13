//
//  VolumeAboutView.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

/// Displays the volume description
final class VolumeAboutView: UIView {

	@IBOutlet private weak var titleLabel: UILabel! {
		didSet {
			titleLabel.text = NSLocalizedString("ABOUT", comment: "")
			titleLabel.textColor = UIColor(named: .darkText)
		}
	}

	@IBOutlet private weak var aboutLabel: UILabel! {
		didSet {
			aboutLabel.textColor = UIColor(named: .darkText)
		}
	}

	/// Bindable observer for the about text
	var about: AnyObserver<String?> {
		return aboutLabel.rx.text.asObserver()
	}
}
