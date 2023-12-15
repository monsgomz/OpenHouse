//
//  ListRecommendationsView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-28.
//

import SwiftUI
//TODO: Revisar diseño
struct ListRecommendationsView: View {
	@EnvironmentObject var model: RecommendationModelView
	
    var body: some View {
		NavigationStack{
			List(model.recommend, id: \.id){ building in
				VStack{
					Text(building.name)
						.font(.caption)
					Text(building.description)
						.font(.caption2)
				}
			}
			.overlay{
				if model.recommend.isEmpty {
					ContentUnavailableView{
						Label("No Recommendations yet", systemImage: "tray.fill")
					} description: {
						Text("Recommend a building first")
					}
				}
			}
			.onAppear(){
				model.fetchAllRecommendations()
			}
			.navigationTitle("Buildings sent")
			.background(Color.background)
		}
    }
}
