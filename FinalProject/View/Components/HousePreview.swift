//
//  HousePreview.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-29.
//

import SwiftUI
//TODO: Revisar diseño
struct HousePreview: View {
	var mapElement: BuildingModel?
	
	
    var body: some View {
		NavigationStack{ //TODO: Revisar!!
			HStack {
				VStack(alignment: .center){
					Image(mapElement!.image.replacingOccurrences(of: ".jpg", with: ""))
						.resizable()
						.aspectRatio(contentMode: .fit)
						.clipShape(RoundedRectangle(cornerRadius: 15.0))
						.frame(width: 240, alignment: .center)
			
					Text(mapElement!.name)
						.foregroundStyle(Color.background)
						.font(.subheadline)
						.bold()
				}
				
			}
			
		}
		.clipShape(RoundedRectangle(cornerRadius: 10.0))
		.frame(width: 380)
		
		
    }
}
//
//#Preview {
//    HousePreview()
//}
