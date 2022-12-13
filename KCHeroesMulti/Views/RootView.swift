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
        case .none:
            LoginView()
        case .register:
            RegisterView()
        case .loading:
            LoaderView()
        case .error(error: let errorString):
            ErrorView(error: errorString)
        case .loaded:
            HeroesView(viewModel: ViewModelHeroes())
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}



