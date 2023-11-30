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
			HStack(spacing: 10){
				Image(favorite.image.replacingOccurrences(of: ".jpg", with: ""))
					.resizable()
					.aspectRatio(contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 15))
					.frame(width: 130, height: 80, alignment: .center)

				VStack(alignment: .leading ,spacing: 10){
					Text(favorite.name)
						.textCase(.uppercase)
						.font(.footnote)

						.bold()
					Text(favorite.address).font(.caption)
					Text("\(modelData.Distance(other: CLLocationCoordinate2D(latitude: favorite.latitude, longitude: favorite.longitude)))KM from you")
						.font(.caption2)
				}
				Spacer()
				
			}
		}
    }
}
//
//#Preview {
//    RowFavoriteView()
//}
