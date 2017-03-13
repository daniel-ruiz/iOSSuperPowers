//
//  UIColor+Darkening.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

extension UIColor {

	/// Returns a darker version of a color
	func darkening(withRatio ratio: CGFloat) -> UIColor {
		var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0

		if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			return UIColor(hue: hue, saturation: saturation, brightness: brightness * (1-ratio), alpha: alpha)
		}

		return self
	}
}
