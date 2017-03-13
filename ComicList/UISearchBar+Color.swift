//
//  UISearchBar+Color.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

extension UISearchBar {

	var searchFieldTextColor: UIColor? {
		get {
			return value(forKeyPath: "searchField.textColor") as? UIColor
		}

		set {
			setValue(newValue, forKeyPath: "searchField.textColor")
		}
	}
}
