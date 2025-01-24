//
//  Reachability.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Network
import SwiftUI


class Monitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published var status: NetworkStatus = .connected
    static let shared = Monitor()
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            // Monitor runs on a background thread so we need to publish
            // on the main thread
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if path.status == .satisfied {
                    print("We're connected!")
                    self.status = .connected
                  

                } else {
                    print("No connection.")
                    self.status = .disconnected
                }
            }
        }
        monitor.start(queue: queue)
    }
}
