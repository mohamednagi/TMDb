//
//  banquemisr_challenge05App.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import SwiftUI
import Network

@main
struct banquemisr_challenge05App: App {
    @StateObject private var monitor = Monitor.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(monitor)
                .preferredColorScheme(.dark)
        }
    }
}
