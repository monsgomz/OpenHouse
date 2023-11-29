//
//  RowHomeView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-26.
//

import SwiftUI
import MapKit

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
//					if (modelData.isFavorite(id: building.buildingId) != nil){
//						Image(systemName: "heart.fill")
//							.foregroundStyle(Color.red)
//							.padding()
//					}
					//TODO: Revisar funcionalidad!
					FavoriteButtonView(id: building.buildingId, isSet: isSet)
						
				}
			//Caja descripcion
			VStack(spacing: 0){
				HStack(alignment: .firstTextBaseline, spacing: 8){
					ShareLink("", item: "Share email", subject: Text("\(building.name)"), message: Text("This is a firendly reminder to submit your assignment on time"))
						.padding(.horizontal, 10)
					Text(building.name)
						.textCase(.uppercase)
						.font(.caption)
						
//					Spacer()
				}
				.frame(width: 340, height: 35, alignment: .center)
				.padding(8)
			.background(Color.white)
				HStack(alignment: .center, spacing: 10){
					Text(building.address)
						.font(.footnote)
						.fontWeight(.bold)
					Spacer()
					Text("\(modelData.Distance(other: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude))) from you")
						.font(.footnote)
				}
				.frame(width: 330, height: 15, alignment: .center)
				.padding(15)
				.background(Color.white)
			}
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
			.shadow(radius: 10)
			
			
		}
    }
}

//#Preview {
//	RowHomeView(building: BuildingModel())
//}
