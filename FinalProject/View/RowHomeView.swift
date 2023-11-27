//
//  RowHomeView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-26.
//

import SwiftUI
import MapKit

struct RowHomeView: View {
	var building: BuildingModel
	@EnvironmentObject var modelData: BuildingModelView
	
    var body: some View {
		VStack(spacing: 0){
			Image(building.image.replacingOccurrences(of: ".jpg", with: ""))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 25.0))
				.padding(.horizontal, 8)
				.overlay(alignment: .topTrailing){
					FavoriteButtonView(id: building.buildingId)
						.padding()
				}
			//Caja descripcion
			VStack(spacing: 0){
				HStack(alignment: .center, spacing: 10){
					Image(systemName: "square.and.arrow.up")
					Text(building.name)
						.font(.subheadline)
					Spacer()
				}
				.frame(width: 340, height: 40, alignment: .center)
				.padding(10)
			.background(Color.indigo)
				HStack(alignment: .center, spacing: 10){
					Text(building.address)
						.font(.footnote)
						.fontWeight(.bold)
					Spacer()
					Text("\(modelData.Distance(other: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)))from you")
						.font(.footnote)
				}
				.frame(width: 330, height: 40, alignment: .center)
				.padding(15)
				.background(Color.green)
			}
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
			.shadow(radius: 10)
			
			
		}
    }
}

//#Preview {
//	RowHomeView(building: BuildingModel())
//}
