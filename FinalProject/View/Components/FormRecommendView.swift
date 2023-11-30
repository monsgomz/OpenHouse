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
	@EnvironmentObject var networkMonitor: NetworkMonitor
	@Environment(\.presentationMode) var presentationMode
	
	@State var picker = 1
	@State var alert = false
	@State var result = false
	@State var title = ""
	@State var text = ""
	
    var body: some View {
		NavigationStack{
			Form {
			if(!networkMonitor.isConnected){
				ContentUnavailableView{
					Label("No Internet", systemImage: "wifi.slash")
						.foregroundStyle(Color.accent)
				} description: {
					Text("You don't have internet connection")
				}
			} else{
				
				
					Section(header: Text("Information")){
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
						newBuilding.category = String(picker)
						
						result = model.saveRecommendation(recommend: newBuilding)
						print(result)
						title = result ? "Sorry!" : "Thank you!"
						
						text = result ? "Sorry There was a problem try later" : "Your recommendation has been received"
						alert.toggle()
					}) {
						Label("Save", systemImage: "paperplane.fill")
					}
					.alert(title, isPresented: $alert){
						Button("OK", action: {self.presentationMode.wrappedValue.dismiss()})
					} message: {
						Text(text)
					}
				}
				
			}
			
			.navigationTitle("Recommendation")
		}
    }
}

#Preview {
	FormRecommendView(newBuilding: RecommendationModel())
}
