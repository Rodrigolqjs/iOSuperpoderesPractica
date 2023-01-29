//
//  RootView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    var body: some View {
        switch (rootViewModel.status) {
        case .loading:
            LoaderView()
        case .error(error: let errorString):
            ErrorView(error: errorString)
        case .loaded:
            MarvelHeroesView(marvelHeroesViewModel: MarvelHeroesViewModel())
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}



