//
//  SavedView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI
//TODO: Revisar si se pueden borrar elementos
struct SavedView: View {
	
	@EnvironmentObject var modelData: BuildingModelView
	@State var elementSelected: Int = 0
	@State var text = ""
	
	
	var filteredSavedBuildings: [BuildingModel] {
		if text.isEmpty {
			return modelData.favoritesFilter(favorite: modelData.favoelements)
		} else {
			return modelData.favoritesFilter(favorite: modelData.favoelements).filter { $0.name.lowercased().contains(text.lowercased()) }
			}
		}
	
	
	var body: some View {
		NavigationStack{
			List{
				ForEach(filteredSavedBuildings, id: \.buildingId){ element in
					NavigationLink{
						DetailsView(info: element)
					}
				label: {
					RowFavoriteView(favorite: element)
				}
					
				}
			}
			.overlay{
				if filteredSavedBuildings.isEmpty {
					ContentUnavailableView{
						Label("No Favorites", systemImage: "tray.fill")
							.foregroundStyle(Color.accent)
					} description: {
						Text("Saved houses will appear here.")
					}
				}
			}
			.searchable(text: $text, prompt: "Look for a building saved")
			.navigationTitle("Favorites")
		}
		.background(Color.green)
		
	}
}
