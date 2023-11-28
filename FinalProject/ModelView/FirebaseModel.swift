//
//  FirebaseModel.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-28.
//

import Foundation


class RecommendationModel: Identifiable {
	let id: String
	var name: String
	var category: String
	var description: String
	
	init(
		id: String = UUID().uuidString,
		name: String,
		category: String,
		description: String
	) {
		self.id = id
		self.name = name
		self.category = category
		self.description = description
	}
	
	convenience init() {
		self.init(name: "", category: "", description: "")
	}
}


