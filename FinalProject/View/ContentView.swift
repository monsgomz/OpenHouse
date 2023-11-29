//
//  ContentView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-24.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var modelData = BuildingModelView()
	@State var model = RecommendationModelView()
	
	
    var body: some View {
		TabView{
			HomeView()
				.tabItem {
					Label("Home", systemImage: "house")
				}
			MapView()
				.tabItem {
					Label("Map", systemImage: "map")
				}
			SavedView()
				.tabItem {
					Label("Favorite", systemImage: "heart")
				}
				.badge(modelData.favoelements.count)
			MoreView()
				.tabItem {
					Label("More", systemImage: "ellipsis.rectangle.fill")
				}

		}
		.tint(Color.accent)
		.environmentObject(modelData)
		.environmentObject(model)
		.onAppear{
			modelData.checkLocactionEnabled()
			modelData.setArrayLocation()
			model.login()
			modelData.setArrayCategories()
			
		}
		
    }
	
}

#Preview {
    ContentView()
}
