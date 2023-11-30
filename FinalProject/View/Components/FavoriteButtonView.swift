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
	@State var isSet: Bool
	
	var body: some View {
		Button {
			
			if let index = modelData.favoelements.firstIndex(of: id) {
				modelData.favoelements.remove(at: index)
			} else {
				modelData.favoelements.append(id)
			}
			print(modelData.favoelements.count)
			isSet.toggle()
			
		} label: {
			Label("Fav", systemImage: isSet ? "heart.fill" : "heart")
				.labelStyle(.iconOnly)
				.foregroundColor(isSet ? .accent : .white)
				.font(.system(size: 24))
		}
		.padding(12)
	}

}


