//
//  SpotAvailabilityViewController.swift
//  RabbleAnalytics
//
//  Created by Mark Keane on 4/7/17.
//  Copyright © 2017 Mark Keane. All rights reserved.
//

import Foundation
import UIKit
import Charts
import GoogleMaps

class SpotAvailabilitySnapshotViewController: UIViewController, GMSMapViewDelegate {
	
	
	var chartView: BarChartView!
	var months: [String]!
	
	var numberOfSpots = 1120
	var numberOfActiveSpots = 990
	var numberOfInactiveSpots = 149
	var numberOfScheduledSpots = 636
	
	var numberOfSpotsLabel = UILabel()
	var numberOfActiveSpotsLabel = UILabel()
	var numberOfInactiveSpotsLabel = UILabel()
	var numberOfScheduledSpotsLabel = UILabel()
	
	var numberOfSpotsDesc = UILabel()
	var numberOfActiveSpotsDesc = UILabel()
	var numberOfInactiveSpotsDesc = UILabel()
	var numberOfScheduledSpotsDesc = UILabel()
	
	var mapView = GMSMapView()
	var mapControlBar = UIButton()
	
	enum MapControlBarStatus {
		case pointingUp
		case pointingDown
	}
	
	var mapControlBarStatus = MapControlBarStatus.pointingUp
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let screenSize: CGRect = UIScreen.main.bounds
		
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		
		
		self.navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatWatermelon, isFlat:true);
		self.title = "Snapshot"
		months = ["Jan"]
		let unitsSold = [20.0]
		chartView = BarChartView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 300))
		setChart(dataPoints: months, values: unitsSold)
		
	//	self.view.addSubview(chartView)
		
		self.view.backgroundColor = UIColor.flatSkyBlue
		
		numberOfSpotsDesc.frame = CGRect(x: 34, y: 20, width: screenWidth*0.45, height: 30)
		numberOfSpotsDesc.text = "Number of spots: "
		numberOfSpotsDesc.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfSpotsDesc.font = numberOfSpotsDesc.font.withSize(20)
		self.view.addSubview(numberOfSpotsDesc)
		
		numberOfActiveSpotsDesc.frame = CGRect(x: 34, y: 80, width: screenWidth*0.45, height: 30)
		numberOfActiveSpotsDesc.text = "Active spots: "
		numberOfActiveSpotsDesc.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfActiveSpotsDesc.font = numberOfSpotsDesc.font.withSize(20)
		self.view.addSubview(numberOfActiveSpotsDesc)
		
		numberOfInactiveSpotsDesc.frame = CGRect(x: 34, y: 140, width: screenWidth*0.45, height: 30)
		numberOfInactiveSpotsDesc.text = "Inactive spots: "
		numberOfInactiveSpotsDesc.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfInactiveSpotsDesc.font = numberOfSpotsDesc.font.withSize(20)
		self.view.addSubview(numberOfInactiveSpotsDesc)
		
		numberOfScheduledSpotsDesc.frame = CGRect(x: 34, y: 200, width: screenWidth*0.45, height: 30)
		numberOfScheduledSpotsDesc.text = "Scheduled spots: "
		numberOfScheduledSpotsDesc.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfScheduledSpotsDesc.font = numberOfSpotsDesc.font.withSize(20)
		self.view.addSubview(numberOfScheduledSpotsDesc)
		
		numberOfSpotsLabel.frame = CGRect(x: screenWidth*0.64, y: 20, width: screenWidth*0.32, height: 30)
		numberOfSpotsLabel.text = String(numberOfSpots)
		numberOfSpotsLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfSpotsLabel.font = numberOfSpotsLabel.font.withSize(35)
		numberOfSpotsLabel.font = UIFont.boldSystemFont(ofSize: 35)
		numberOfSpotsLabel.textAlignment = NSTextAlignment.center
		self.view.addSubview(numberOfSpotsLabel)
		
		numberOfActiveSpotsLabel.frame = CGRect(x: screenWidth*0.64, y: 80, width: screenWidth*0.32, height: 30)
		numberOfActiveSpotsLabel.text = String(numberOfActiveSpots)
		numberOfActiveSpotsLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfActiveSpotsLabel.font = numberOfActiveSpotsLabel.font.withSize(35)
		numberOfActiveSpotsLabel.font = UIFont.boldSystemFont(ofSize: 35)
		numberOfActiveSpotsLabel.textAlignment = NSTextAlignment.center
		self.view.addSubview(numberOfActiveSpotsLabel)
		
		numberOfInactiveSpotsLabel.frame = CGRect(x: screenWidth*0.64, y: 140, width: screenWidth*0.32, height: 30)
		numberOfInactiveSpotsLabel.text = String(numberOfInactiveSpots)
		numberOfInactiveSpotsLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfInactiveSpotsLabel.font = numberOfActiveSpotsLabel.font.withSize(35)
		numberOfInactiveSpotsLabel.font = UIFont.boldSystemFont(ofSize: 35)
		numberOfInactiveSpotsLabel.textAlignment = NSTextAlignment.center
		self.view.addSubview(numberOfInactiveSpotsLabel)
		
		numberOfScheduledSpotsLabel.frame = CGRect(x: screenWidth*0.64, y: 200, width: screenWidth*0.32, height: 30)
		numberOfScheduledSpotsLabel.text = String(numberOfScheduledSpots)
		numberOfScheduledSpotsLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatSkyBlue, isFlat:true)
		numberOfScheduledSpotsLabel.font = numberOfActiveSpotsLabel.font.withSize(35)
		numberOfScheduledSpotsLabel.font = UIFont.boldSystemFont(ofSize: 35)
		numberOfScheduledSpotsLabel.textAlignment = NSTextAlignment.center
		self.view.addSubview(numberOfScheduledSpotsLabel)
		
		let camera = GMSCameraPosition.camera(withLatitude: 37.886080, longitude: -122.137585, zoom: 7.0)
		mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: screenHeight*0.65, width: screenWidth, height: screenHeight*0.88), camera: camera)
		mapView.delegate = self
		self.view.addSubview(mapView)
		
		let circleCenter = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
		let circ = GMSCircle(position: circleCenter, radius: 2000)
		circ.fillColor = UIColor.flatWatermelonDark.withAlphaComponent(0.5)
		
		
		//37.886080, -122.137585
		//37.899356, -122.130203
		//37.900101, -122.104282
		//37.879644, -122.101192
		
		let rect = GMSMutablePath()
		rect.add(CLLocationCoordinate2D(latitude: 37.886080, longitude: -122.137585))
		rect.add(CLLocationCoordinate2D(latitude: 37.899356, longitude: -122.130203))
		rect.add(CLLocationCoordinate2D(latitude: 37.900101, longitude: -122.104282))
		rect.add(CLLocationCoordinate2D(latitude: 37.879644, longitude: -122.101192))
		let polygon = GMSPolygon(path: rect)
		polygon.fillColor = UIColor.flatWatermelonDark.withAlphaComponent(0.5)
		polygon.strokeColor = .black
		polygon.strokeWidth = 2
		polygon.isTappable = true
		polygon.map = mapView
		polygon.title = "Lafayette"

		circ.map = mapView
		
		mapControlBar.setTitle("↑        ↑", for: .normal)
		mapControlBar.setTitleColor(UIColor(contrastingBlackOrWhiteColorOn:UIColor.flatGrayDark, isFlat:true), for: .normal)
		mapControlBar.frame = CGRect(x: 0, y: screenHeight*0.59, width: screenWidth, height: screenHeight*0.06)
		mapControlBar.addTarget(self, action:#selector(self.mapBarPressed), for: .touchUpInside)
		mapControlBar.backgroundColor = UIColor.flatGrayDark
		
		self.view.addSubview(mapControlBar)
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setChart(dataPoints: [String], values: [Double]) {
		chartView.noDataText = "You need to provide data for the chart."
		var dataEntries: [BarChartDataEntry] = []
		
		for i in 0..<dataPoints.count {
			//	let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
			let dataEnrty = BarChartDataEntry(x: values[i], y: Double(i))
			dataEntries.append(dataEnrty)
		}
		
		let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
		//	let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
		let chartData = BarChartData(dataSet: chartDataSet)
		chartView.data = chartData
	}
	
	func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
		print("FUCKME")
		print("User Tapped Layer: \(overlay)")
		print("Overlay title: ", overlay.title)
		
	}
	
	func mapBarPressed() {
		let screenSize: CGRect = UIScreen.main.bounds
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		
		if mapControlBarStatus == MapControlBarStatus.pointingUp {
			mapControlBarStatus = MapControlBarStatus.pointingDown
			self.mapControlBar.setTitle("↓         ↓", for: .normal)
			UIView.animate(withDuration: 0.5, animations: {
				self.mapView.frame = CGRect(x: 0, y: screenHeight*0.1, width: screenWidth, height: screenHeight*0.88)
				self.mapControlBar.frame = CGRect(x: 0, y:screenHeight*0.04, width: screenWidth, height: screenHeight*0.06)
			})
		} else if mapControlBarStatus == MapControlBarStatus.pointingDown {
			mapControlBarStatus = MapControlBarStatus.pointingUp
			mapControlBar.setTitle("↑        ↑", for: .normal)
			UIView.animate(withDuration: 0.5, animations: {
				self.mapView.frame = CGRect(x: 0, y: screenHeight*0.65, width: screenWidth, height: screenHeight*0.88)
				self.mapControlBar.frame = CGRect(x: 0, y: screenHeight*0.59, width: screenWidth, height: screenHeight*0.06)
			})
		}
		print("Button Clicked")
	}
	
	
}

