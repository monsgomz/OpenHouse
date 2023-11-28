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
	@State var picker = ""
    var body: some View {
		NavigationStack{
			Form{
				Section(header: Text("Informtion")){
					TextField("Name of the building", text: $newBuilding.name)
					Picker(selection: $newBuilding.category, label: Text("Category")) {
						Text("1").tag(1)
						Text("2").tag(2)
					}
				}
				Section(header: Text("Description")){
					TextField("Write a description of the building", text: $newBuilding.description)
				}
				Button{
					model.saveRecommendation(recommend: newBuilding)
				} label: {
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
