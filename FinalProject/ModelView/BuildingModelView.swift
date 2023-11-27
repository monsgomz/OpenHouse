//
//  BuildingModelView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import Foundation
import SwiftUI
import MapKit

class BuildingModelView: NSObject, ObservableObject, CLLocationManagerDelegate {
	
	@Published var buildingData: [BuildingData] = FinalProject.load("buildings")
	@Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.424440220535125, longitude:  -75.70094318813211), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
	@Published var locations: [Location] = []
	@Published var favoelements: [Int] = []
	
	
	var locationManager: CLLocationManager?
	
	/// Function to check the location enabled
	func checkLocactionEnabled(){
		if CLLocationManager.locationServicesEnabled(){
			locationManager = CLLocationManager()
			locationManager?.delegate = self
			
		} else{
			print("Show an alert")
		}
	}
	
	private func checkLocationAuthorization(){
		guard let locationManager = locationManager else { return }
		
		switch locationManager.authorizationStatus {
			
		case .notDetermined:
			// ask for permision
			locationManager.requestWhenInUseAuthorization()
		case .restricted:
			print("Your location is restricted") //alert
		case .denied:
			print("You have denied the location") //alert
		case .authorizedAlways, .authorizedWhenInUse:
			region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
		@unknown default:
			break
		}
	}
	
	/// To know when de user gives authorization
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthorization()
	}
	
	func setArrayLocation(){
	
		for building in  buildingData[0].buildings{
				let newLocation = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
				let location = Location(name: building.name, coordinate: newLocation)
				locations.append(location)
			}
		
	}
	
	func isFavorite(id:Int) -> BuildingModel?{
		return buildingData[0].buildings.first(where: {$0.buildingId == id}) ?? nil
	}
	
	func Distance(other: CLLocationCoordinate2D) -> CLLocationDistance {
		let otherLocation = CLLocation(latitude: other.latitude, longitude: other.longitude)
	
		guard let distanceFromMe = locationManager?.location?.distance(from: otherLocation) else { return 0.0}
		
		return distanceFromMe / 1000.0
	}
	func favoritesFilter(favorite: [Int]) -> [BuildingModel]{
		return buildingData[0].buildings.filter{ element in
			favorite.contains(element.buildingId)
		}
			
	}
	
}

/// Function to read the file and transform in JSON object
/// - Parameter filename: Name of the file
/// - Returns: JSON object
func load(_ filename: String) -> [BuildingData] {
	let data: Data
	
	guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
	else {
		fatalError("Couldn't find \(filename) in main bundle.")
	}
	
	
	do {
		data = try Data(contentsOf: file)
	} catch {
		fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
	}
	
	
	do {
		let decoder = JSONDecoder()
		
		return try decoder.decode([BuildingData].self, from: data)
	} catch {
		fatalError("Couldn't parse \(filename) as \([BuildingData].self):\n\(error)")
	}
	}
