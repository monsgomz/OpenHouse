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
	
	func dateFormat(date: String, includeDay: Bool = true) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
		let dateFormatted = dateFormatter.date(from: date)!
		
		if includeDay {
			dateFormatter.dateFormat = "EEEE d HH:mm"
		} else {
			dateFormatter.dateFormat = "HH:mm"
		}
		
		return dateFormatter.string(from: dateFormatted)
	}
	
    var body: some View {
		NavigationStack{ //TODO: Revisar!!
			HStack {
				VStack(alignment: .center){
					Image(mapElement!.image.replacingOccurrences(of: ".jpg", with: ""))
						.resizable()
						.aspectRatio(contentMode: .fit)
						.clipShape(RoundedRectangle(cornerRadius: 15.0))
						.frame(width: 200, alignment: .center)
			
					Text(mapElement!.name)
						.foregroundStyle(Color.background)
						.font(.subheadline)
						.bold()
				}
				VStack{
					Text("Open Hours")
						.foregroundStyle(Color.background)
						.font(.subheadline)
						.bold()
						.padding(.top, 10)
					if(mapElement!.isOpenSaturday){
						Text(dateFormat(date: mapElement!.saturdayStart!))
							.foregroundStyle(Color.background)
							.font(.caption)
						Text("-")
							.font(.caption)
						Text(dateFormat(date: mapElement!.saturdayClose!, includeDay: false))
							.foregroundStyle(Color.background)
							.font(.caption)
						
					} else if(mapElement!.isOpenSunday){
						Text(dateFormat(date: mapElement!.sundayStart!))
							.foregroundStyle(Color.background)
							.font(.caption)
						Text("-")
							.font(.caption)
						Text(dateFormat(date: mapElement!.sundayClose!, includeDay: false))
							.foregroundStyle(Color.background)
							.font(.caption)
					} else {
						Text("Is close")
					}
					Spacer()
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
