//
//  MapView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI
import MapKit

struct MapView: View {
	
	@EnvironmentObject var modelData: BuildingModelView
	@State private var selectedTag: Int?
	@State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
	@State private var selectedResult: Int?
	
	var body: some View {
		VStack{
			Map(position: $position, selection: $selectedResult){
				ForEach(modelData.locations){ element in

					Marker(element.name, coordinate: element.coordinate)
						.tag(Int.random(in: 0..<100))
				}
				UserAnnotation()
			}
			.mapStyle(.standard(elevation: .realistic))
			.safeAreaInset(edge: .bottom){
				if selectedResult != nil{
					HousePreview()
						.shadow(radius: 10)
				}
			}
			.mapControls{
				MapUserLocationButton()
				MapCompass()
				MapScaleView()
			}
			
			
		}
		
	}
}

