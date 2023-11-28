//
//  gome0145_mad9137_final_projectApp.swift
//  gome0145-mad9137-final-project
//
//  Created by Montserrat Gomez on 2023-11-24.
//

import SwiftUI
import Firebase

@main
struct finalProjectApp: App {
	init() {
		FirebaseApp.configure()
	}
	
    var body: some Scene {
        WindowGroup {
            SplashView()
				
        }
    }
}
