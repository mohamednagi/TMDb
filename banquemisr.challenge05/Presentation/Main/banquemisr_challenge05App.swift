//
//  banquemisr_challenge05App.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import SwiftUI
import Network
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let memoryCapacity = 500 * 1024 * 1024
    private let diskCapacity = 1000 * 1024 * 1024
    private let diskPath = "/Users/mohamednagi/Desktop/Learning/SwiftUI"
    private var cache: URLCache?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
        guard let _ = cache else {return false}
        URLCache.shared = cache!
        return true
    }
}

@main
struct banquemisr_challenge05App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var monitor = Monitor.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(monitor)
                .preferredColorScheme(.dark)
        }
    }
}
