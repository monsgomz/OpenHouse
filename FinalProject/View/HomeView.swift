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
	@State var isShowing = false
	@State var filter: FilterType = .none
	@State var sort: SortType = .none
	@State private var alphabetically = false
	@State private var distance = false
	
	
	var body: some View {
		NavigationStack{
			ScrollView {
				LazyVStack(spacing:15){
					ForEach(modelData.filteredData(filter: filter, sort: sort, text: text), id: \.buildingId){ data in
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
			})

		}
		
	}
}

