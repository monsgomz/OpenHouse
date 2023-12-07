//
//  HousePreview.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-29.
//

import SwiftUI

struct HousePreview: View {
	var mapElement: BuildingModel?
	
    var body: some View {
		NavigationStack{ //TODO: Revisar!!
			HStack {
				VStack(alignment: .center){
					Image(mapElement!.image.replacingOccurrences(of: ".jpg", with: ""))
						.resizable()
						.aspectRatio(contentMode: .fit)
						.clipShape(RoundedRectangle(cornerRadius: 25.0))
						.frame(width: 100, height: 100, alignment: .center)
					Text(mapElement!.name)
						.foregroundStyle(Color.background)
						.font(.caption)
						.bold()
				}
				VStack{
					Text("Open Hours")
						.foregroundStyle(Color.background)
						.font(.caption)
						.bold()
					if(mapElement!.isOpenSaturday){
						Text("Saturday: ")
							.foregroundStyle(Color.background)
							.font(.footnote)
						Text(mapElement!.saturdayStart!)
							.foregroundStyle(Color.background)
							.font(.footnote)
						Text(mapElement!.saturdayClose!)
							.foregroundStyle(Color.background)
							.font(.footnote)
						
					} else if(mapElement!.isOpenSunday){
						Text("Sunday: ")
							.font(.footnote)
							.foregroundStyle(Color.background)
							.font(.footnote)
						Text(mapElement!.sundayStart!)
							.foregroundStyle(Color.background)
							.font(.footnote)
						Text(mapElement!.sundayClose!)
							.foregroundStyle(Color.background)
							.font(.footnote)
					} else {
						Text("Is close")
					}
				}
			}
			
		}
		
//		.padding()
		.clipShape(RoundedRectangle(cornerRadius: 20.0))
//		.background(Color.accent)
//		.clipShape(RoundedRectangle(cornerRadius: 20.0))
		.frame(width: 380)
		
		
    }
}
//
//#Preview {
//    HousePreview()
//}
