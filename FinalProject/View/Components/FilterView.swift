//
//  FilterView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-12-03.
//

import SwiftUI

struct FilterView: View {
	@EnvironmentObject var modelData: BuildingModelView
	@Binding var isShowing: Bool
	@Binding var filter: FilterType
	@Binding var sort: SortType
	@Binding var alphabetically: Bool
	@Binding var distance: Bool

	
    var body: some View {
		NavigationStack{
			ScrollView {
				Section(header: Text("Sort")) {
					Toggle(
						"Alphabetically",
						systemImage: "textformat.abc",
						isOn: $alphabetically
					)
					Toggle(
						"Distance from you",
						systemImage: "person.line.dotted.person.fill",
						isOn: $distance
					)
				}
				
				Section(header: Text("By categories")) {
					ForEach(modelData.categories, id: \.id) { element in
						HStack {
							Image(systemName: element.selected ? "circle.inset.filled" : "circlebadge")
							Text(element.name)
							Spacer()
						}
						.padding(.horizontal)
						.onTapGesture{ 
							modelData.filterDataCategory(elementSelected: element)
						}
					}
				}
				
				Section(header: Text("By amenities")) {
					ForEach(modelData.amenities, id:\.id) { element in
						HStack {
							Image(systemName: element.selected ? "circle.inset.filled" : "circlebadge")
							Image(element.image)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 20)
								.padding(.trailing, 8)
								
							Text(element.name)
							Spacer()
						}
						.padding(.horizontal)
						.onTapGesture {
							modelData.filterDataAmenities(elementSelected: element)
							
						}
					}
				}
			
				
			}
			.navigationTitle("Filter")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar{
				ToolbarItem{
					Button("Done"){
						print(modelData.categories.first{$0.selected} ?? "none")
						print(modelData.amenities.first{$0.selected}  ?? "none")
						
						if(modelData.categories.first{$0.selected} != nil && modelData.amenities.first{$0.selected} != nil){
							filter = .categoiresAdnAmenities
						} else if(modelData.categories.first{$0.selected} != nil){
							filter = .categories
						} else if(modelData.amenities.first{$0.selected} != nil){
							filter = .amenities
						}
						else {
								filter = .none
							}
						
							if(alphabetically){
								sort = .alphabetically
							} else if(distance){
								sort = .distance
							} else {
								sort = .none
							}
						
						
						isShowing.toggle()
					}
				}
			}
			
		}
    }
}


