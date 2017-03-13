//
//  ReusableView.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

/// See [iOS Cell Registration & Reusing with Swift Protocol Extensions and Generics](https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e#.hi9bpcmnf)
protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {

	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}
