//
// Copyright © 2019 Marlon Pina Tojal All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_: UIApplication,
	                 didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		App.shared.didFinishLaunching()

		return true
	}

	func applicationWillResignActive(_: UIApplication) {}

	func applicationDidEnterBackground(_: UIApplication) {}

	func applicationWillEnterForeground(_: UIApplication) {}

	func applicationDidBecomeActive(_: UIApplication) {}

	func applicationWillTerminate(_: UIApplication) {}
}