//
//  HomeView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI

struct HomeView: View {
	@EnvironmentObject var modelData: BuildingModelView
	
    var body: some View {
		ScrollView {
			LazyVStack{
				ForEach(modelData.buildingData[0].buildings, id: \.buildingId){ data in
					RowHomeView(building: data)
					
				}
			}
			.padding()
		}
    }
}

#Preview {
    HomeView().environmentObject(BuildingModelView())
}
