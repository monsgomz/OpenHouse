//
//  HomeView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI

struct HomeView: View {
	@EnvironmentObject var modelData: BuildingModelView
	@State var text = ""
	var body: some View {
		NavigationStack{
			ScrollView {
				LazyVStack(spacing:10){
					ForEach(modelData.buildingData[0].buildings, id: \.buildingId){ data in
						RowHomeView(building: data)
						
					}
				}
				
				.padding()
				
			}
			.searchable(text: $text)
			.navigationTitle("Home")
		}
		
	}
}

#Preview {
	HomeView().environmentObject(BuildingModelView())
}
