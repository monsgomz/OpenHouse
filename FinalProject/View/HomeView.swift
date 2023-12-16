//
//  HomeView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI

//TODO: ajustar diseño
struct HomeView: View {
	
	@EnvironmentObject var modelData: BuildingModelView
	@State var text = ""
	@State var isShowing = false
	@State var filter: FilterType = .none
	@State var sort: SortType = .none
	@State private var alphabetically = false
	@State private var distance = false
	
	var filteredBuildings: [BuildingModel] {
		if text.isEmpty {
			return modelData.filteredData(filter: filter, sort: sort, text: text)
		} else {
			return modelData.filteredData(filter: .search, sort: sort, text: text)
		}
	}
	
	var body: some View {
		NavigationStack{
			ScrollView {
				LazyVStack(spacing:15){
					ForEach(filteredBuildings, id: \.buildingId){ data in
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

			.searchable(text: $text, prompt: "Look for a building")
			.navigationTitle("Home")
			.toolbar{
				ToolbarItem{
					Image(systemName: "line.3.horizontal.decrease.circle")
						.foregroundStyle(Color.accentColor)
						.onTapGesture {
							isShowing.toggle()
						}
				}
			}
			.sheet(isPresented: $isShowing, content: {
				FilterView(isShowing: $isShowing, filter: $filter, sort: $sort, alphabetically: $alphabetically, distance: $distance)
					.presentationContentInteraction(.scrolls)
			})
		}
	}
}

