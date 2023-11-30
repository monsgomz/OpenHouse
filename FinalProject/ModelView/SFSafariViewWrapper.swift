//
//  SFSafariViewWrapper.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-29.
//

import Foundation
import SwiftUI
import SafariServices
struct SFSafariViewWrapper: UIViewControllerRepresentable {
	let url: URL
	func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
		return SFSafariViewController(url: url)
	}
	func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
		return
	}
}
