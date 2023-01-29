//
//  KCHeroesMultiApp.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 30/11/22.
//

import SwiftUI

@main
struct KCHeroesMultiApp: App {
    @StateObject var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}

