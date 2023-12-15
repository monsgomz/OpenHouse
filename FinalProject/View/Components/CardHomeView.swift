//
//  RowHomeView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-26.
//

import SwiftUI
import MapKit
//TODO: Revisar favoritos
struct CardHomeView: View {
	
	var building: BuildingModel
	@EnvironmentObject var modelData: BuildingModelView
	var isSet: Bool {
		modelData.isFavorite(id: building.buildingId)
	}
	
    var body: some View {
		VStack(spacing: 0){
			Image(building.image.replacingOccurrences(of: ".jpg", with: ""))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 25.0))
				.padding(.horizontal, 8)
				.overlay(alignment: .topTrailing){

					FavoriteButtonView(id: building.buildingId, isSet: isSet)
				}
			//Caja descripcion
			VStack(spacing: 0){
				HStack(alignment: .center, spacing: 8){
					ShareLink("", item: building.name, subject: Text("Look this building!!"), message: Text("I want to share with you this important building."))
						.foregroundStyle(Color.background)
						.padding(.horizontal, 10)
					Text(building.name)
						.textCase(.uppercase)
						.font(.caption)
						.foregroundStyle(Color.background)
				}
				.frame(width: 310, height: 40, alignment: .leading)
				.padding(5)

				HStack(alignment: .center, spacing: 10){
					Text(building.address)
						.font(.footnote)
						.fontWeight(.bold)
						.foregroundStyle(Color.background)
					Spacer()
					Text("\(modelData.Distance(other: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude))) from you")
						.font(.footnote)
						.foregroundStyle(Color.background)
				}
				.padding(.horizontal, 5)
				.frame(width: 310, height: 40, alignment: .leading)
			}
			.background(Color.accent)
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
			.offset(x:0, y: -30.0)
			.shadow(radius: 10)
		}
    }
}

//#Preview {
//	RowHomeView(building: BuildingModel())
//}
