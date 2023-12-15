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
	@Published var french: Int = 0
	@Published var categories: [Category] = [
		Category(id: 0, name: "Religious buildings", selected: false),
	Category(id: 1, name: "Embassies", selected: false),
	Category(id: 2, name: "Government buildings", selected: false),
	Category(id: 3, name: "Functional buildings", selected: false),
	Category(id: 4, name: "Galleries and Theatres", selected: false),
	Category(id: 5, name: "Academic Institutions", selected: false),
	Category(id: 6, name: "Sports and Leisure buildings", selected: false),
	Category(id: 7, name: "Community and/or Care centres", selected: false),
	Category(id: 8, name: "Business and/or Foundations", selected: false),
	Category(id: 9, name: "Museums, Archives and Historic Sites", selected: false),
	Category(id: 10, name: "Other", selected: false)]
	
	@Published var amenities: [Amenities] = [
		Amenities(id: 0, image: "newBuilding", name: "isNew", selected: false, newName: "New"),
		Amenities(id: 1, image: "shuttle", name: "isshuttle", selected: false, newName: "Shuttle"),
		Amenities(id: 2, image: "washroom", name: "isPublicWashrooms", selected: false, newName: "Public Washroom"),
		Amenities(id: 3, image: "accessibility", name: "isAccessible", selected: false, newName: "Accessibility"),
		Amenities(id: 4, image: "freeParking", name: "isFreeParking", selected: false, newName: "Free Parking"),
		Amenities(id: 5, image: "bikeracks", name: "isBikeParking", selected: false, newName: "Bike Parking"),
		Amenities(id: 6, image: "paidParking", name: "isPaidParking", selected: false, newName: "Paid Parking"),
		Amenities(id: 7, image: "guidedTour", name: "isGuidedTour", selected: false, newName: "Guided Tour"),
		Amenities(id: 8, image: "familyFriendly", name: "isFamilyFriendly", selected: false, newName: "Family Friendly"),
		Amenities(id: 9, image: "ocTranspo", name: "isOCTranspoNearby", selected: false, newName: "Near OC Transpo"),
	]
	
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
	
	/// Function to check the status of location
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
	
	
	/// Function to set a new array with locations
	func setArrayLocation(){
		for building in  buildingData[french].buildings{
				let newLocation = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
				let location = Location(name: building.name, coordinate: newLocation)
				locations.append(location)
			}
	}
	
	
	/// Function to check if the element is favorite
	/// - Parameter id: buildingId
	/// - Returns: Bool
	func isFavorite(id:Int) -> Bool{
		if ((favoelements.first(where: {$0 == id})) != nil){
			return true
		}
		return false
	}
	
	
	/// Function to calculate the distance bewteen user and location
	/// - Parameter other: a location building
	/// - Returns: km
	func Distance(other: CLLocationCoordinate2D) -> String {
		let otherLocation = CLLocation(latitude: other.latitude, longitude: other.longitude)
		
		guard let distanceFromMe = locationManager?.location?.distance(from: otherLocation) else { return "0"}
		
		return String(format: "%.2f", distanceFromMe/1000.0)
	}
	
	
	/// Function to return an array of favorite elements
	/// - Parameter favorite: array of favorites
	/// - Returns: array of Buildings
	func favoritesFilter(favorite: [Int]) -> [BuildingModel]{
		return buildingData[french].buildings.filter{ element in
			favorite.contains(element.buildingId)
		}
	}
	func filterDataCategory(elementSelected: Category){
		self.categories[elementSelected.id].selected.toggle()
	}
	
	func filterDataAmenities(elementSelected: Amenities){
		self.amenities[elementSelected.id].selected.toggle()
	}
	
	func mapFilter(mapElementName: String) -> BuildingModel?{
		return buildingData[french].buildings.first{$0.name == mapElementName} ?? nil
		
	}
	
	func filteredData(filter: FilterType, sort: SortType, text: String) -> [BuildingModel] {
		
		var filteredData: [BuildingModel] = []
		
		switch filter {
		case .none:
			filteredData = buildingData[french].buildings
		case .categories:
			filteredData = buildingData[french].buildings.filter { edificio in
				let categoriaSeleccionada = categories.first { $0.id == edificio.categoryId }
				return categoriaSeleccionada?.selected ?? false
			}
		case .amenities:
			let selectedAmenities = amenities.filter { $0.selected }
			
			filteredData = buildingData[french].buildings.filter { building in
				selectedAmenities.allSatisfy { amenity in
					let amenityName = amenity.name
					
					switch amenityName {
					case "isNew":
						return building.isNew
					case "isshuttle":
						return building.isShuttle
					case "isPublicWashrooms":
						return building.isPublicWashrooms
					case "isAccessible" :
						return building.isAccessible
					case "isFreeParking" :
						return building.isFreeParking
					case "isBikeParking" :
						return building.isBikeParking
					case "isPaidParking" :
						return building.isPaidParking
					case "isGuidedTour" :
						return building.isGuidedTour
					case "isFamilyFriendly" :
						return building.isFamilyFriendly
					case "isOCTranspoNearby" :
						return building.isOCTranspoNearby
					default:
						return false
					}
				}
			}
		
		case .search:
			filteredData = buildingData[french].buildings.filter { $0.name.lowercased().contains(text.lowercased()) }
			
		case .categoiresAdnAmenities:
			let selectedAmenities = amenities.filter { $0.selected }
			
			filteredData = buildingData[french].buildings.filter { building in
				selectedAmenities.allSatisfy { amenity in
					let amenityName = amenity.name
					
					switch amenityName {
					case "isNew":
						return building.isNew
					case "isshuttle":
						return building.isShuttle
					case "isPublicWashrooms":
						return building.isPublicWashrooms
					case "isAccessible" :
						return building.isAccessible
					case "isFreeParking" :
						return building.isFreeParking
					case "isBikeParking" :
						return building.isBikeParking
					case "isPaidParking" :
						return building.isPaidParking
					case "isGuidedTour" :
						return building.isGuidedTour
					case "isFamilyFriendly" :
						return building.isFamilyFriendly
					case "isOCTranspoNearby" :
						return building.isOCTranspoNearby
					default:
						return false
					}
				}
			}
//			print(filteredData.count)
			
			filteredData = buildingData[french].buildings.filter { edificio in
				let categoriaSeleccionada = categories.first { $0.id == edificio.categoryId }
				return categoriaSeleccionada?.selected ?? false
			}
			
		}
		
		switch sort{
			
		case .none:
			filteredData
			
		case .alphabetically:
			filteredData.sort { $0.name < $1.name }
			
		case .distance:
			filteredData.sort { building1, building2 in
				guard let location = locationManager?.location else {
					return false
				}
				
				let location1 = CLLocation(latitude: building1.latitude, longitude: building1.longitude)
				let location2 = CLLocation(latitude: building2.latitude, longitude: building2.longitude)
				
				let distance1 = location.distance(from: location1)
				let distance2 = location.distance(from: location2)
				
				return distance1 < distance2
			}
			
		}
		
		return filteredData
		
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



