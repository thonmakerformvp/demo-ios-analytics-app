//
//  AppDelegate.swift
//  RabbleAnalytics
//
//  Created by Mark Keane on 4/7/17.
//  Copyright © 2017 Mark Keane. All rights reserved.
//

import UIKit
import ChameleonFramework
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var navController: UINavigationController?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		//var colorArray = ColorSchemeOf(ColorScheme(rawValue: 10)!, color:  UIColor.flatWatermelon, isFlatScheme: true)
		window = UIWindow(frame: UIScreen.main.bounds)
		let mainController = TheRootViewController()
		mainController.view.backgroundColor =  UIColor.flatGreenDark
		let navigationController = UINavigationController(rootViewController: mainController)
		navigationController.navigationBar.isTranslucent = false
		navigationController.navigationBar.topItem?.title = "Menu"
		navigationController.navigationBar.barTintColor = UIColor.flatWatermelon
		navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatWatermelon, isFlat:true)]
	
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
	
		GMSServices.provideAPIKey("AIzaSyDmh6WiLX5MHgq7QRzV8h0o3i78ghzccmM")
		
		// Override point for customization after application launch.
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

