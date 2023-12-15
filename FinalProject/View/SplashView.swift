//
//  SplashView.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-27.
//

import SwiftUI

struct SplashView: View {
	
	@State var isActive: Bool = false
	
	var body: some View {
		ZStack {
			if self.isActive {
				ContentView()
			} else {
				Rectangle()
					.fill(Color("Background"))
				Image("ic_logo")
					.resizable()
					.scaledToFit()
					.frame(width: 300, height: 300)
			}
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
				withAnimation {
					self.isActive = true
				}
			}
		}
		.ignoresSafeArea()
	}
	
}

#Preview {
	SplashView()
}
