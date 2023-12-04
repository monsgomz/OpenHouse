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
	@State var showSafari: Bool = false
	@State var isViewed = false
	

	func dateFormat(date: String) -> Date{
		// Create Date Formatter
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//		let dateFormatted = dateFormatter.date(from: date)!
//		let dateComponents = Calendar.current.dateComponents([.day, .month, .hour, .minute], from: dateFormatted)
////		let componentsString = String(dateComponents.) + "/ " + String(dateComponents.month) + "/ " + String(dateComponents.hour) + " -" + String( dateComponents.minute)
//		print(dateComponents.weekdayOrdinal ?? "weekDay")
//		print(dateComponents.description )
//		print(dateComponents.day ?? "day" )
//		print(dateComponents.weekday ?? "weekday")
//		print(dateComponents.
		
//		formatter.dateStyle = .long

//		dateFormatter.dateStyle = .medium
		let dateFormatted = dateFormatter.date(from: date)!
		
		return dateFormatted
		
	}
	
    var body: some View {
		NavigationStack{
			ScrollView{
				ZStack(alignment: .bottomTrailing){
					
				Image(info.image.replacingOccurrences(of: ".jpg", with: ""))
					.resizable()
					.aspectRatio(contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 25.0))
					.frame(width: 380, alignment: .center)
					.shadow(radius: 10)
					.padding(8)
					.overlay(alignment: .topTrailing){
//						FavoriteButtonView(id: info.buildingId, isSet: isSet)
						Image("newBuilding")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.foregroundStyle(Color.white)
							.frame(width: 40)
							.padding()
					}
					Text(info.imageDescription)
						.font(.caption)
						.padding()
						.background(Color.accent)
					.clipShape(RoundedRectangle(cornerRadius: 20))
					.foregroundStyle(Color.white)
					.frame(width: 370)
					.offset(x: -5, y: 25)
					.padding()
					
			}
				//Name information
				HStack(spacing: 10){
					ShareLink("", item: info.name, subject: Text("Look this building!!"), message: Text("I want to share with you this important building."))
					Text(info.name)
						.multilineTextAlignment(.leading)
						.lineLimit(2, reservesSpace: true)
						.bold()
					Spacer()
				}
				.frame(width: 360, height: 30, alignment: .center)
				.padding(10)
				
				HStack{
					CategoryView(info: info)
					
				}
				// Open Hours
				VStack(alignment: .leading, spacing: 10){
					Text("Open Hours")
						.font(.title2)
						.bold()
						.padding(.top, 10)
					HStack(spacing: 8){
						if(info.isOpenSaturday){
							VStack{
								Text("Saturday: ")
								Text("\(dateFormat(date:info.saturdayStart!))")
								Text(info.saturdayClose!)
							}
							
						} 
						if(info.isOpenSunday){
							VStack{
								Text("Sunday: ")
								Text(info.sundayStart!)
								Text(info.sundayClose!)
							}
						} else {
							Text("Is close")
						}
					}
					.padding(10)
				}
				.padding(15)
				.frame(width: 360, height: 120, alignment: .leading)
				.background(Color.white)
				.clipShape(RoundedRectangle(cornerRadius: 20.0))
				.shadow(radius: 10)
//				.padding(10)
				
				Text("Description")
					.font(.title2)
					.bold()
					.padding()
				Text(info.description)
					.multilineTextAlignment(.leading)
					.lineLimit(isViewed ? 20 : 5)
					.frame(width: 360, alignment: .leading)
//					.padding(15)
				HStack{
					Spacer()
					Button(isViewed ? "Read Less" : "Read More" ) {
						isViewed.toggle()
					}
					.font(.system(size: 15, weight: .semibold))
					.padding(.trailing, 10)
				}
				.padding(15)
				AmenitiesView(info: info)
				
				if(info.website != nil) {
					HStack {
						Text("Read more information")
						Image(systemName: "laptopcomputer")
							.onTapGesture {
								showSafari.toggle()
							}
							.fullScreenCover(isPresented: $showSafari, content: {
								SFSafariViewWrapper(url: URL(string: "\(info.website ?? "https://www.google.com")")!)
							})
					}
					.padding(10)
					
				}
				Text("Location")
					.font(.title2)
					.bold()
					.padding()
				HStack{
					Image(systemName: "map.circle.fill")
					Text(info.address)
						.font(.subheadline)
						.foregroundStyle(Color.gray)
					Spacer()
				}
				.padding(.leading, 15)
				Map(bounds:
						MapCameraBounds(minimumDistance: 4500,
										maximumDistance: 4500)){
					Marker(info.name,coordinate: CLLocationCoordinate2D(latitude: info.latitude, longitude:  info.longitude))
				}
				.clipShape(RoundedRectangle(cornerRadius: 25.0))
				.frame(width: 360, height: 360, alignment: .center)
				.padding(.bottom, 20)
				Spacer()
				
			}

		}
		.toolbar{
			ToolbarItem(placement: .navigationBarTrailing) {
				FavoriteButtonView(id: info.buildingId, isSet: isSet)
			}
		}
//		.background(LinearGradient(colors: [Color("Background"), Color.white], startPoint: .top, endPoint: .bottom))
		
		
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

				HStack {
					Spacer()
					if(checkAmenities().count > 5){
						DisclosureGroup("More") {
							
								ForEach(amenities.suffix(from: 5), id: \.self) { element in
									
									Image(element).resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 30, height: 30, alignment: .center)
								}
							
						}
						
					}
				}
				
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
