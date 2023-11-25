//
//  ContentView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-24.
//

import SwiftUI

struct ContentView: View {
	@StateObject var modelData = BuildingModelView()
	
    var body: some View {
        VStack {
			
			Text("\(modelData.buildingData.count)")
			ForEach(modelData.buildingData[0].buildings, id: \.buildingId){ data in
				Text(data.name)
				
			}
				
			
        }
        .padding()
		.environmentObject(modelData)
		
    }
	
}

#Preview {
    ContentView()
}
