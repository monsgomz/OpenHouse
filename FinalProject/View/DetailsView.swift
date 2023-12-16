//
//  DetailsView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI
import MapKit
//TODO: ajustar diseño
struct DetailsView: View {
	
	var info: BuildingModel
	@EnvironmentObject var modelData: BuildingModelView
	var isSet: Bool {
		modelData.isFavorite(id: info.buildingId)
	}
	@State var showSafari: Bool = false
	@State var isViewed = false
	
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
							if(info.isNew){
								Image("nuevo-2")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.foregroundStyle(Color.white)
									.shadow(color: .black, radius: 2, x: 0, y: 0)
									.frame(width: 40)
									.padding()
							}
						}
					Text(info.imageDescription)
						.font(.caption)
						.foregroundStyle(Color.background)
						.padding()
						.background(Color.accent)
						.clipShape(RoundedRectangle(cornerRadius: 20))
						.foregroundStyle(Color.white)
						.frame(width: 380)
						.offset(x: -5, y: 25)
						.padding(.bottom, 30)
					
				}
				//Name information
				HStack(alignment: .top, spacing: 10){
					ShareLink("", item: info.name, subject: Text("Look this building!!"), message: Text("I want to share with you this important building."))
					Text(info.name)
						.multilineTextAlignment(.leading)
						.lineLimit(2, reservesSpace: true)
						.bold()
					Spacer()
				}
				.frame(width: 360, height: 30, alignment: .top)
//				.padding(.bottom, 8)
				
				HStack{
					CategoryView(info: info)
				}
				.padding()
				// Open Hours
				VStack(alignment: .leading, spacing: 10){
					Text("Open Hours")
						.font(.title2)
						.bold()
						.padding(.top, 10)
					HStack(spacing: 8){
						if(info.isOpenSaturday){
							
							Text("\(dateFormat(date:info.saturdayStart!))")
								.font(.callout)
							Text("-")
							Text("\(dateFormat(date:info.saturdayClose!, includeDay: false))")
						}
					}
					HStack(spacing: 8){
						if(info.isOpenSunday){
							
							Text("\(dateFormat(date:info.sundayStart!))")
							Text("-")
							Text("\(dateFormat(date:info.sundayClose!, includeDay: false))")
						}
					}
					Spacer()
				}
				.padding(15)
				.frame(width: 360, height: 125, alignment: .leading)
//				.foregroundStyle(Color.background)
				.border(.accent, width: 2)
				.clipShape(RoundedRectangle(cornerRadius: 20.0))
				
				
				Text("Description")
					.font(.title2)
					.bold()
					.padding()
				Text(info.description)
					.multilineTextAlignment(.leading)
					.lineLimit(isViewed ? 20 : 5)
					.frame(width: 360, alignment: .leading)
				
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
		.navigationTitle("Building details")
		.toolbar{
			ToolbarItem(placement: .navigationBarTrailing) {
				FavoriteButtonView(id: info.buildingId, isSet: isSet)
			}
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
			.foregroundStyle(Color.accent)
			.bold()
			.frame(width: 210, height: 40, alignment: .center)
			.background(Color("greyColor"))
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
				
				
			}
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
			
		}
		.frame(width: 360, height: 80, alignment: .center)
		.padding()
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
