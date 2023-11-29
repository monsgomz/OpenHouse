//
//  FirebaseModelView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-28.
//

import Foundation
import Firebase

class RecommendationModelView: ObservableObject {
	@Published var recommend: [RecommendationModel] = []
	private let recoemmendCollectionRef = Firestore.firestore().collection("recommendations")
	
	init() {
		fetchAllRecommendations()
	}
	
	/// LogIn
	func login() {
		Auth.auth().signIn(withEmail: "general_user@gmail.com", password: "123456") { (result, error) in
			if error != nil {
				print(error?.localizedDescription ?? "")
			} else {
				print("Login successful")
			}
		}
	}
	
	
	/// Save new information
	/// - Parameter recommend: Object to save
	func saveRecommendation(recommend: RecommendationModel) -> Bool {
		let ref = recoemmendCollectionRef.document(recommend.id)
		var flag = false
		
		ref.setData(
			[
				"id": recommend.id,
				"name": recommend.name,
				"category":recommend.category,
				"description": recommend.description
			]
		) {
			error in
			if let error = error {
				print(error.localizedDescription)
				
			} else {
				if !self.recommend.contains(where: { $0.id == recommend.id }) {
					self.recommend.append(recommend)
					flag = true
				}
			}
		}
		return flag
	}
	
	
	/// Fetch all the information
	func fetchAllRecommendations() {
		self.recommend.removeAll()
		recoemmendCollectionRef.getDocuments {
			snapshot,
			error in
			guard error == nil else {
				print(error?.localizedDescription as Any)
				return
			}
			
			if let snapshot = snapshot {
				for document in snapshot.documents {
					let data = document.data()
					
					let id = data["id"] as? String ?? ""
					let name = data["name"] as? String ?? ""
					let category = data["category"] as? String ?? ""
					let description = data["description"] as? String ?? ""
					
					let newRecommendation = RecommendationModel(
						id: id,
						name: name,
						category: category,
						description: description
					)
					self.recommend.append(newRecommendation)
				}
			}
		}
	}
	
	//TODO: REVISAR
	func notifications() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
			if success {
				print("All set!")
			} else if let error = error {
				print(error.localizedDescription)
			}
		}
		
		let content = UNMutableNotificationContent()
		content.title = "New note"
		content.subtitle = "New  note added"
		content.sound = UNNotificationSound.default
		content.launchImageName = "heart"
		
		// show this notification five seconds from now
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 14, repeats: false)
		
		// choose a random identifier
		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		
		// add our notification request
		UNUserNotificationCenter.current().add(request)
	}
	
	
}


