//
//  BuildingModel.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-24.
//

import SwiftUI
import MapKit

struct BuildingData: Codable {
	let language: String
	let version: Int
	let year: Int
	let buildings: [BuildingModel]
}


class BuildingModel: Codable, Hashable{
	func hash(into hasher: inout Hasher) {
		hasher.combine(buildingId)
	}
	static func == (lhs: BuildingModel, rhs: BuildingModel) -> Bool {
		return lhs.buildingId == rhs.buildingId
	}
		var buildingId: Int
		var name: String
		var isNew: Bool
		var address: String
		var description: String
		var website: String?
		var categoryId: Int
		var category: String
		var saturdayStart: String?
		var saturdayClose: String?
		var sundayStart: String?
		var sundayClose: String?
		var isShuttle: Bool
		var isPublicWashrooms: Bool
		var isAccessible: Bool
		var isFreeParking: Bool
		var isBikeParking: Bool
		var isPaidParking: Bool
		var isGuidedTour: Bool
		var isFamilyFriendly: Bool
		var image: String
		var isOCTranspoNearby: Bool
		var imageDescription: String
		var latitude: Double
		var longitude: Double
		var isOpenSaturday: Bool
		var isOpenSunday: Bool

}

struct Location: Identifiable {
	let id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
}

struct Category {
	var id: Int
	var name: String
	var selected: Bool
}

struct Amenities {
	var id: Int
	var image: String
	var name: String
	var selected: Bool
}

enum FilterType {
	case none, categories, amenities, search, categoiresAdnAmenities
	}

enum SortType {
	case none, alphabetically, distance
}
