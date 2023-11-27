//
//  ContentView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-24.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var modelData = BuildingModelView()
	
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
			MoreView()
				.tabItem {
					Label("More", systemImage: "ellipsis.rectangle.fill")
				}

		}
		.environmentObject(modelData)
		.onAppear{
			modelData.checkLocactionEnabled()
			modelData.setArrayLocation()
		}
		
    }
	
}

#Preview {
    ContentView()
}
