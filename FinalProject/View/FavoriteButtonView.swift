//
//  FavoriteButtonView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-26.
//

import SwiftUI

struct FavoriteButtonView: View {
	@EnvironmentObject var modelData: BuildingModelView
	var id: Int
	@State var isSet = false
	
	var body: some View {
		Button {
			
			if((modelData.isFavorite(id: id)) != nil){
				modelData.favoelements.append(id)
				isSet.toggle()
			}
			
		} label: {
			Label("Fav", systemImage: isSet ? "heart.fill" : "heart")
				.labelStyle(.iconOnly)
				.foregroundColor(isSet ? .indigo : .gray)
				.font(.system(size: 24))
		}
		.padding(12)
	}
}
