//
//  AboutMeView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI

struct AboutMeView: View {
	
	@State var showSafari: Bool = false
	@State var isViewed = false
	
    var body: some View {
		NavigationStack {
			ScrollView{
				Image("me")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 200, alignment: .center)
					.padding()
				Text("Montserrat Gomez")
					.font(.title3)
					.bold()
					.padding(8)
				Text("iOS Developer")
					.font(.headline)
					.padding()
				Text("She is a computer systems engineer with experience in backend and business process automation.")
					
				Text("Motivated by mobile development, she is studying a diploma in mobile design and development allowing her to find her passion for application development.")
					.padding()
				VStack{
					Text("Technologies:")
						.font(.headline)
						.padding()
					HStack {
						
						Text("• Swift")
						Text("• SwiftUI")
						Text("• Flutter")

					}
					
					Text("Hobbies:")
						.font(.headline)
						.padding()
					HStack {
						
						Text("• Watercolor painting")
						Text("• Read books")
						
					}
					HStack{
						Text("• Dog lover")
						Text("• Videogames")
					}
				}
				.frame(width: 320, alignment: .leading)
				.padding(8)
				.overlay( 
					RoundedRectangle(cornerRadius: 20)
						.stroke(.accent, lineWidth: 2)
				)
				
				
				Text("Contact & some of my projects")
					.font(.headline)
					.padding()
					Label("montserrat.ga95@gmail.com", systemImage: "envelope.badge")
					.padding(8)
				
				Label("GitHub", systemImage: "laptopcomputer")
						.onTapGesture {
							showSafari.toggle()
						}
						.fullScreenCover(isPresented: $showSafari, content: {
							SFSafariViewWrapper(url: URL(string: "https://github.com/monsgomz")!)
						})
						.padding(8)
				
				Label("Dribble", systemImage: "laptopcomputer")
						.onTapGesture {
							showSafari.toggle()
						}
						.fullScreenCover(isPresented: $showSafari, content: {
							SFSafariViewWrapper(url: URL(string: "https://dribbble.com/Monzgomz/likes")!)
						})
						.padding(10)
			}
			.navigationTitle("About Me")
			
		}
    }
}

#Preview {
    AboutMeView()
}
