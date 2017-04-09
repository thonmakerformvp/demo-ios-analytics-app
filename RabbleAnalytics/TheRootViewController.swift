//
//  TheRootViewController.swift
//  RabbleAnalytics
//
//  Created by Mark Keane on 4/7/17.
//  Copyright © 2017 Mark Keane. All rights reserved.
//

import Foundation
import UIKit

class TheRootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var myTableView: UITableView  =   UITableView()
	var itemsToLoad: [String] = ["Spot Availability", "UI Logs", "Bookings"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let screenSize: CGRect = UIScreen.main.bounds
		
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		
		myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
		
		myTableView.dataSource = self
		myTableView.delegate = self
		
		myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
		
		self.view.addSubview(myTableView)
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemsToLoad.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
		
		cell.textLabel?.text = self.itemsToLoad[indexPath.row]
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("User selected table row \(indexPath.row) and item \(itemsToLoad[indexPath.row])")
		print(indexPath.row)
		if indexPath.row == 0 {
			let spotAvailViewController = SpotAvailabilityViewController()
			self.navigationController?.pushViewController(spotAvailViewController, animated: true)
		}
	}
	
}
