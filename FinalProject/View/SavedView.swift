//
//  SavedView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI

struct SavedView: View {
	@EnvironmentObject var modelData: BuildingModelView
	@State var elementSelected: Int = 0
	
	
    var body: some View {
		let favoritesArray = modelData.favoritesFilter(favorite: modelData.favoelements)
		NavigationStack{
			List{
				ForEach(favoritesArray, id: \.buildingId){ element in
					
					NavigationLink{
						DetailsView(info: element)
					}
					label: {
					RowFavoriteView(favorite: element)
					}
					
				}
//
			}
			.overlay{
				if favoritesArray.isEmpty {
					ContentUnavailableView{
						Label("No Favorites", systemImage: "tray.fill")
							.foregroundStyle(Color.accent)
					} description: {
						Text("Saved houses will appear here.")
					}
				}
			}
			.navigationTitle("Favorites")

			
		}
		
		
    }

}
