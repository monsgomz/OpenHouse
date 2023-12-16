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
				.clipShape(RoundedRectangle(cornerRadius: 15.0))
				.padding(.horizontal, 8)
				.overlay(alignment: .topTrailing){

					FavoriteButtonView(id: building.buildingId, isSet: isSet)
				}
			//Caja descripcion
			VStack(spacing: 0){
				HStack(alignment: .center, spacing: 8){
					ShareLink("", item: building.name, subject: Text("Look this building!!"), message: Text("I want to share with you this important building."))
						.foregroundStyle(Color.accent)
						.padding(.horizontal, 10)
					Text(building.name)
						.textCase(.uppercase)
						.font(.caption)
						.bold()
						.foregroundStyle(Color.accent)
				}
				.frame(width: 310, height: 40, alignment: .leading)
//				.padding(5)

				HStack(alignment: .center, spacing: 10){
					Text(building.address)
						.font(.footnote)
						.fontWeight(.bold)
						.foregroundStyle(Color.accent)
					Spacer()
					Text("\(modelData.Distance(other: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude))) from you")
						.font(.footnote)
						.foregroundStyle(Color.accent)
				}
				.padding(.horizontal, 5)
				.frame(width: 310, height: 40, alignment: .leading)
			}

		}
		.frame(width: 340)
		.padding(8)
		.overlay( /// apply a rounded border
			RoundedRectangle(cornerRadius: 20)
				.stroke(.accent, lineWidth: 2)
		)
		.shadow(radius: 10)
		
//		.border(.accent, width: 2)
		
    }
}

//#Preview {
//	RowHomeView(building: BuildingModel())
//}
