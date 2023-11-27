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
						NavigationLink{
							DetailsView(info: data)
						}
					label:{
						CardHomeView(building: data)
					}
				}
				}
				
				.padding()
				
			}
			.searchable(text: $text)
			.navigationTitle("Home")
		}
		.toolbar{
			ToolbarItem{
				Image(systemName: "line.3.horizontal.decrease.circle")
			}
		}
		
	}
}

#Preview {
	HomeView().environmentObject(BuildingModelView())
}
