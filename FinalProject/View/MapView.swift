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
	
    var body: some View {
		VStack{
			Map(coordinateRegion: $modelData.region, showsUserLocation: true, annotationItems: modelData.locations){ location in
				MapAnnotation(coordinate: location.coordinate) {
					ZStack {
						Circle()
							.fill(Color.teal)
						Image(systemName: "house.fill")
							.foregroundStyle(Color.white)
							.padding(5)
					}
				}
			} //map
			.accentColor(.pink)
			.edgesIgnoringSafeArea(.top)

		}

    }
}
