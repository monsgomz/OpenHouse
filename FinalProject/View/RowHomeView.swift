//
//  RowHomeView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-26.
//

import SwiftUI

struct RowHomeView: View {
	var building: BuildingModel
	
    var body: some View {
		VStack(spacing: 0){
			Image("aids_ottawa")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 25.0))
				.padding(.horizontal, 8)
				.overlay(alignment: .topTrailing){
					Image(systemName: "heart.fill")
						.foregroundStyle(Color.red)
						.font(.system(size: 25))
						.padding()
				}
			//Caja descripcion
			VStack(spacing: 0){
				HStack(alignment: .center, spacing: 10){
					Image(systemName: "square.and.arrow.up")
	//				Text(building.name)
					Text(building.name)
					Spacer()
				}
				.frame(width: 340, height: 40, alignment: .center)
				.padding(10)
			.background(Color.indigo)
				HStack(alignment: .center, spacing: 10){
					Text(building.address)
					Spacer()
					Text("3.4 km from you")
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
