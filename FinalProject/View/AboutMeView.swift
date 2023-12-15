//
//  AboutMeView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI

struct AboutMeView: View {
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
						Text("• React Native")
					}
					
					Text("Hobbies:")
						.font(.headline)
						.padding()
					HStack {
						
						Text("• Swift")
						Text("• SwiftUI")
						Text("• Flutter")
						Text("• React Native")
					}
				}
				.frame(width: 360, alignment: .leading)
				.background(Color.white)
				.padding(8)
				.clipShape(RoundedRectangle(cornerRadius: 20.0))
				.shadow(radius: 10)
				
				Text("Contact & some of my projects")
					.font(.headline)
					.padding()
				HStack{
					Image(systemName: "laptopcomputer")
					Image(systemName: "envelope.badge")
					Image(systemName: "laptopcomputer")
					Image(systemName: "laptopcomputer")
				}

				
			}
			.navigationTitle("About Me")
			
		}
    }
}

#Preview {
    AboutMeView()
}
