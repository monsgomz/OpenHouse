//
//  DetailsView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI
import MapKit

struct DetailsView: View {
	var info: BuildingModel
	@EnvironmentObject var modelData: BuildingModelView
	var isSet: Bool {
		modelData.isFavorite(id: info.buildingId)
	}
	
    var body: some View {
		ScrollView{
			Image(info.image.replacingOccurrences(of: ".jpg", with: ""))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 25.0))
				.frame(width: 380, height: 400, alignment: .center)
				.shadow(radius: 10)
				.padding(8)
				.overlay(alignment: .topTrailing){
					FavoriteButtonView(id: info.buildingId, isSet: isSet)
						.padding()
				}
			//Name information
			HStack(spacing: 10){
				Image(systemName: "square.and.arrow.up")
				Text(info.name)
					.multilineTextAlignment(.leading)
					.lineLimit(2)
//					.font(.title)
				.bold()
				Spacer()
			}
			.frame(width: 360, height: 30, alignment: .center)
			Text(info.address)
				.font(.subheadline)
			
			HStack{
				CategoryView(info: info)
			
			}
			// Open Hours
			VStack(alignment: .leading, spacing: 10){
				Text("Open Hours")
					.font(.title2)
					.bold()
				HStack(spacing: 8){
					if(info.isOpenSaturday){
						VStack{
							Text("Staurday: ")
							Text(info.saturdayStart)
							Text(info.saturdayClose)
						}
						
					} else if(info.isOpenSunday){
						VStack{
							Text("Sunday: ")
							Text(info.sundayStart!)
							Text(info.sundayClose!)
						}
					} else {
						Text("Is close")
					}
				}
				.padding()
			}
			.padding(8)
			.frame(width: 360, height: 120, alignment: .leading)
			.background(Color.red)
			.clipShape(RoundedRectangle(cornerRadius: 20.0))
			.shadow(radius: 10)
			.padding(10)
			
			Text("Description")
				.font(.title2)
				.bold()
			Text(info.description)
				.multilineTextAlignment(.leading)
				.frame(minWidth: 360, idealWidth: 370, maxWidth: 380, minHeight: 180, idealHeight: 180, maxHeight: .infinity, alignment: .center)
				.padding(10)
			
			AmenitiesView(info: info)
			
			Text("Location")
				.font(.title2)
				.bold()
			Map{
				Marker(info.name,coordinate: CLLocationCoordinate2D(latitude: info.latitude, longitude:  info.longitude))
			}
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
			.frame(width: 360, height: 360, alignment: .center)
			Spacer()
			
		}
		
    }
}

//#Preview {
//	DetailsView(info: BuildingModel())
//}

struct CategoryView: View {
	var info: BuildingModel

	var body: some View {
	
		Text(info.category)
			.font(.caption)
			.foregroundStyle(Color.white)
			.bold()
			.frame(width: 210, height: 40, alignment: .center)
			.background(Color("ColorLightGrey"))
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
			.padding(5)
	}
}

struct AmenitiesView: View {
	var info: BuildingModel
	
	var body: some View {
		let amenities = checkAmenities()
		
		Text("Amenities")
			.font(.title3)
			.bold()
		VStack{
			HStack{
				ForEach(amenities.prefix(4), id: \.self){ element in
					Image(element)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30, alignment: .center)
				}
				.fixedSize(horizontal: false, vertical: true)
//				HStack {
					if(checkAmenities().count > 5){
						DisclosureGroup("More") {
							HStack{
								ForEach(amenities.suffix(from: 5), id: \.self) { element in
									
									Image(element).resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 30, height: 30, alignment: .center)
								}
							}
						}
					}
//				}
				
			}
			.frame(width: 360, height: 60, alignment: .center)
			.padding()
			
		}
	}
	
	func checkAmenities() -> [String]{
		
		return [
			info.isNew ? "newBuilding" : "",
			info.isShuttle ? "shuttle" : "",
			info.isPublicWashrooms ? "washroom" : "",
			info.isAccessible ? "accessibility" : "",
			info.isFreeParking ? "freeParking" : "",
			info.isBikeParking ? "bikeracks" : "",
			info.isPaidParking ? "paidParking" : "",
			info.isGuidedTour ? "guidedTour" : "",
			info.isFamilyFriendly ? "familyFriendly" : "",
			info.isOCTranspoNearby ? "ocTranspo" : ""
		].filter { !$0.isEmpty }

	}
}
