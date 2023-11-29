//
//  HousePreview.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-29.
//

import SwiftUI

struct HousePreview: View {
    var body: some View {
		
		HStack {
			VStack(alignment: .center){
				Image("aids_ottawa")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 25.0))
					.frame(width: 100, height: 100, alignment: .center)
				Text("Name")
			}
			VStack{
				Text("Open Hours")
				Text("Saturday")
				Text("dd-mm-yyyy 00-00-00")
				Text("dd-mm-yyyy 00-00-00")
				Text("Sunday")
				Text("dd-mm-yyyy 00-00-00")
				Text("dd-mm-yyyy 00-00-00")
			}
			
		}
		.padding()
		.clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    HousePreview()
}
