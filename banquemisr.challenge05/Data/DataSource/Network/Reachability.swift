//
//  Reachability.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Network
import SwiftUI


class Monitor: ObservableObject {
    
    @Published var status: NetworkStatus = .connected

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    static let shared = Monitor()
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            // Monitor runs on a background thread so we need to publish
            // on the main thread
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if path.status == .satisfied {
                    self.status = .connected
                  

                } else {
                    self.status = .disconnected
                }
            }
        }
        monitor.start(queue: queue)
    }
}
