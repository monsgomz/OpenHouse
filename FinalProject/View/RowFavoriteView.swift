//
//  RowFavoriteView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI
import MapKit

struct RowFavoriteView: View {
	var favorite: BuildingModel
	@EnvironmentObject var modelData: BuildingModelView
	
    var body: some View {
		VStack{
			HStack{
				Image(favorite.image.replacingOccurrences(of: ".jpg", with: ""))
					.resizable()
					.aspectRatio(contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 15))
					.frame(width: 130, height: 80, alignment: .center)
					.padding(5)
				VStack(alignment: .leading ,spacing: 10){
					Text(favorite.name)
						.textCase(.uppercase)
						.font(.subheadline)
						.bold()
					Text(favorite.address).font(.caption)
					Text("\(modelData.Distance(other: CLLocationCoordinate2D(latitude: favorite.latitude, longitude: favorite.longitude)))%.0f KM from you").font(.footnote)
				}
				
			}
		}
    }
}
//
//#Preview {
//    RowFavoriteView()
//}
