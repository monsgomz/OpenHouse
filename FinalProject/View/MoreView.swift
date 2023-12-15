//
//  MoreView.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-25.
//

import SwiftUI

struct MoreView: View {
	@State var french: Bool = false
	@EnvironmentObject var modelData: BuildingModelView
	
	var body: some View {
		NavigationStack {
			List{
				Section(header: Text("Language")){
					Toggle(isOn: $french) {
						Label("French", systemImage: "character.bubble.fill")
					}
					.onChange(of: french){
						modelData.french = french ? 1 : 0
					}
				}
				Section(header: Text("Recommendations")){
					NavigationLink{
						FormRecommendView()
					}
				label:{
					Label("Recommend a building", systemImage: "house.and.flag")
					}
					NavigationLink{
						ListRecommendationsView()
					}
				label:{
					Label("Recommendations sent", systemImage: "tray.full.fill")
					}
				}
				Section(header: Text("Team")){
					NavigationLink{
						AboutMeView()
					}
				label:{
					Label("Meet the team", systemImage: "person.2.fill")
					}
				}
			}
			.background(Color.green)
			.navigationTitle("More")
		}
		.background(Color.green)
	}
}

#Preview {
	MoreView()
}
