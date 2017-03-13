//
//  UITableView+Reusable.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

/// See [iOS Cell Registration & Reusing with Swift Protocol Extensions and Generics](https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e#.hi9bpcmnf)

extension UITableViewCell: ReusableView {
}

extension UITableView {

	func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
		register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

	func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)

		register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

	func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(for row: Int) -> T where T: ReusableView {
		return dequeueReusableCell(for: IndexPath(row: row, section: 0))
	}
}
