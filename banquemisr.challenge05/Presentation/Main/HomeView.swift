//
//  ContentView.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 21/01/2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            TabView {
                NowPlayingView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Now Playing", systemImage: "film.fill")
                    }
                
                PopularView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Popular", systemImage: "star.fill")
                    }
                
                UpcomingView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Upcoming", systemImage: "calendar.circle")
                    }
            }
        }
    }
}

#Preview {
    HomeView()
}
