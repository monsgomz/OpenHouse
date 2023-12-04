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
//	@Published var filteredData: [BuildingModel] = []
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
		Amenities(id: 0, image: "newBuilding", name: "isNew", selected: false),
	Amenities(id: 1, image: "shuttle", name: "isshuttle", selected: false),
	Amenities(id: 2, image: "washroom", name: "isPublicWashrooms", selected: false),
	Amenities(id: 3, image: "accessibility", name: "isAccessible", selected: false),
	Amenities(id: 4, image: "freeParking", name: "isFreeParking", selected: false),
	Amenities(id: 5, image: "bikeracks", name: "isBikeParking", selected: false),
	Amenities(id: 6, image: "paidParking", name: "isPaidParking", selected: false),
	Amenities(id: 7, image: "guidedTour", name: "isGuidedTour", selected: false),
	Amenities(id: 8, image: "familyFriendly", name: "isFamilyFriendly", selected: false),
	Amenities(id: 9, image: "ocTranspo", name: "isOCTranspoNearby", selected: false),
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
		for building in  buildingData[0].buildings{
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
		return buildingData[0].buildings.filter{ element in
			favorite.contains(element.buildingId)
		}
	}
	
	
	func mapFilter(mapElementName: String) -> BuildingModel?{
		return buildingData[0].buildings.first{$0.name == mapElementName} ?? nil
		
	}
	
	func filterDataCategory(elementSelected: Category){
		self.categories[elementSelected.id].selected.toggle()
	}
	
	func filterDataAmenities(elementSelected: Amenities){
		self.amenities[elementSelected.id].selected.toggle()
	}
	
	func filteredData(filter: FilterType, sort: SortType, text: String) -> [BuildingModel] {
		
		var filteredData: [BuildingModel] = []
		
		switch filter {
		case .none:
			filteredData = buildingData[0].buildings
		case .categories:
			filteredData = buildingData[0].buildings.filter { edificio in
				let categoriaSeleccionada = categories.first { $0.id == edificio.categoryId }
				return categoriaSeleccionada?.selected ?? false
			}
		case .amenities:
			filteredData = buildingData[0].buildings.filter { building in
				amenities.allSatisfy { amenity in
					let amenityKey = amenity.name
					let mirror = Mirror(reflecting: building)
					
					if let value = mirror.children.first(where: { $0.label == amenityKey })?.value as? Bool {
						return value == true && amenity.selected
					}
					
					return false
				}
			}
			
		case .search:
			filteredData = buildingData[0].buildings.filter { $0.name.contains(text) }
			
		case .categoiresAdnAmenities:
			filteredData = buildingData[0].buildings.filter { edificio in
				let categoriaSeleccionada = categories.first { $0.id == edificio.categoryId }
				let amenidadesSeleccionadas = amenities.allSatisfy { amenity in
					let amenityKey = amenity.name
					let mirror = Mirror(reflecting: edificio)
					
					if let value = mirror.children.first(where: { $0.label == amenityKey })?.value as? Bool {
						return value == true && amenity.selected
					}
					
					return false
				}
				return (categoriaSeleccionada?.selected ?? false) && amenidadesSeleccionadas
			}
			
		}
		
		switch sort{
			
		case .none:
			filteredData
			
		case .alphabetically:
			filteredData.sort { $0.name < $1.name }
			
		case .distance:
			filteredData.sorted { building1, building2 in
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



