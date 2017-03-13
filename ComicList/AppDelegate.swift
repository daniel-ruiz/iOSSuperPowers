//
//  AppDelegate.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var coordinator: AppCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		let window = UIWindow(frame: UIScreen.main.bounds)

		coordinator = AppCoordinator(window: window)
		coordinator?.start()

		return true
	}
}
