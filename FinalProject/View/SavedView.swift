//
//  SavedView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI

struct SavedView: View {
	@EnvironmentObject var modelData: BuildingModelView
	
	
	
    var body: some View {
		let favoritesArray = modelData.favoritesFilter(favorite: modelData.favoelements)
		NavigationStack{
			List{
				ForEach(favoritesArray, id: \.self){element in
					NavigationLink{
						DetailsView(info: element)
					}
				label: {
					RowFavoriteView(favorite: element)
				}
				}
//				.onDelete(perform: { indexSet in
//					if let index = modelData.favoelements.firstIndex(of: indexSet.hashValue-1) {
//						modelData.favoelements.remove(at: index)
//					}
//				})
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
//			.toolbar{
//				ToolbarItem(placement: .navigationBarLeading,
//							content: {
//					EditButton()}
//				)
//			}
			
		}
		
		
    }

}

#Preview {
    SavedView().environmentObject(BuildingModelView())
}
