//
//  KCHeroesMultiApp.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 30/11/22.
//

import SwiftUI

@main
struct KCHeroesMultiApp: App {
    var body: some Scene {
        WindowGroup {
            MarvelHeroesView(marvelHeroesViewModel: MarvelHeroesViewModel())
        }
    }
}

