//
//  NetworkMonitor.swift
//  FinalProject
//
//  Created by Montserrat Gomez on 2023-11-29.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
	private let networkMonitor = NWPathMonitor()
	private let workerQueue = DispatchQueue(label: "Monitor")
	var isConnected = false
	init() {
		networkMonitor.pathUpdateHandler = { path in
			self.isConnected = path.status == .satisfied
			Task {
				await MainActor.run {
					self.objectWillChange.send()
				}
			}
		}
		networkMonitor.start(queue: workerQueue)
	}
}
