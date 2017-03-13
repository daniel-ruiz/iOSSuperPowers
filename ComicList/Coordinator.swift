//
//  Coordinator.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

/// A coordinator encapsulates navigation logic
class Coordinator: NSObject {

	private(set) weak var parent: Coordinator?
	private(set) var children: [Coordinator] = []

	/// Tells the coordinator to start its work, i.e. present a view controller.
	func start() {
	}

	/// Marks the coordinator as finished.
	///
	/// The coordinator will remove itself from its parent.
	final func done() {
		parent?.remove(child: self)
	}

	/// Add a child coordinator
	final func add(child: Coordinator) {
		children.append(child)
		child.parent = self
	}

	private func remove(child: Coordinator) {
		let index = children.index {
			$0 === child
		}

		if let index = index {
			print("removing coordinator \(child)")
			children.remove(at:index)
		}
	}
}
