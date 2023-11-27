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
	@State var searchText = ""
	
    var body: some View {
	
		VStack{
			Map(coordinateRegion: $modelData.region, showsUserLocation: true, annotationItems: modelData.locations){ location in
				MapAnnotation(coordinate: location.coordinate) {
					Circle()
						.stroke(.red, lineWidth: 3)
						.frame(width: 44, height: 44)
				}
			}
			.accentColor(.pink)
			
		}
		.searchable(text: $searchText)
    }
}
