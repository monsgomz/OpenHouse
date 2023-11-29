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
					print("picker: \(picker)")
					newBuilding.category = String(picker)
					model.saveRecommendation(recommend: newBuilding)
				}) {
					Label("Save", systemImage: "paperplane.fill")
				}
			}
			.navigationTitle("Recommendation")
		}
    }
}

#Preview {
	FormRecommendView(newBuilding: RecommendationModel())
}
