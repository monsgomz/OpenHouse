//
//  FormRecommendView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI

struct FormRecommendView: View {
	@State var newBuilding: RecommendationModel = RecommendationModel()
	@EnvironmentObject var model: RecommendationModelView
	@EnvironmentObject var modelData: BuildingModelView
	@State var picker = 1
	@State var alert = false
	@Environment(\.presentationMode) var presentationMode
	@State var result = false
	@State var title = ""
	@State var text = ""
	
    var body: some View {
		NavigationStack{
			Form {
				Section(header: Text("Informtion")){
					TextField("Name of the building", text: $newBuilding.name)
					Picker(selection: $picker, label: Text("Category")) {
						ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
							Text("\(modelData.categories[key] ?? "")").tag(key)
						}
						

					}
				}
				Section(header: Text("Description")){
					TextField("Write a description of the building", text: $newBuilding.description)
				}
				Button(action: {
//					print("picker: \(picker)")
					newBuilding.category = String(picker)
					alert.toggle()
					result = model.saveRecommendation(recommend: newBuilding)
					title = result ? "Thank you!" : "Sorry!"
					text = result ? "Your recommendation has been received" : "Sorry There was a problem try later"
				}) {
					Label("Save", systemImage: "paperplane.fill")
				}
				.alert(title, isPresented: $alert){
					Button("OK", action: {self.presentationMode.wrappedValue.dismiss()})
				} message: {
					Text("Your recommendation has been received")
				}
			}
			.navigationTitle("Recommendation")
		}
    }
}

#Preview {
	FormRecommendView(newBuilding: RecommendationModel())
}
