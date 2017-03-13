//
//  CoverView.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import ImageLoader

final class CoverView: UIView {

	// MARK: Properties

	/// The url of the cover image
	var url: URL? {
		didSet {
			didSetURL()
		}
	}
	
	// MARK: Initialization

	init() {
		super.init(frame: CGRect.zero)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: Overrides

	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.frame = bounds
	}

	// MARK: - Private

	private let imageView = UIImageView()
	private let loader = ImageLoader.shared
	private var disposeBag: DisposeBag?

	/// A bindable observer for remote images
	private var image: AnyObserver<UIImage?> {

		return UIBindingObserver(UIElement: imageView) { imageView, image in
			// If there is an error (image is nil) we should cancel any ongoing
			// animations and reset our image view
			guard let image = image else {
				imageView.layer.removeAllAnimations()
				imageView.image = nil

				return
			}

			// Add a fade animation and set the image
			imageView.layer.add(CATransition.fade, forKey: kCATransition)
			imageView.image = image
		}.asObserver()
	}

	private func didSetURL() {
		// This will cancel any ongoing download
		self.disposeBag = nil
		imageView.image = nil

		guard let url = url else {
			return
		}

		let disposeBag = DisposeBag()

		// Load the image and bind the result to our observer property
		loader.image(for: url)
			.bindTo(image)
			.addDisposableTo(disposeBag)

		self.disposeBag = disposeBag
	}

	private func setup() {
		addSubview(imageView)

		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
	}
}

private extension CATransition {

	static var fade: CATransition {
		let transition = CATransition()
		transition.duration = 0.25
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionFade

		return transition
	}
}
