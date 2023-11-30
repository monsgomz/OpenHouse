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
	@State private var selectedResult: String? = nil
	@State private var elementSelected: BuildingModel?
	
	var body: some View {
		VStack{
			Map(position: $position, selection: $selectedResult){
				ForEach(modelData.locations){ element in

					Marker(element.name, systemImage: "house.and.flag.fill" ,coordinate: element.coordinate)
						.tag(element.name)
						
				}
				UserAnnotation()
				
			}.onChange(of: selectedResult){
				elementSelected = modelData.mapFilter(mapElementName: selectedResult ?? "")
			}
			.mapStyle(.standard(elevation: .realistic))
			.safeAreaInset(edge: .bottom){
				if selectedResult != nil && elementSelected != nil{
					HousePreview(mapElement: elementSelected)
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

