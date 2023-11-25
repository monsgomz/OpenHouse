//
//  BuildingModelView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import Foundation
import SwiftUI

class BuildingModelView: ObservableObject {
	
	@Published var buildingData: [BuildingData] = load("buildings")
	
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
