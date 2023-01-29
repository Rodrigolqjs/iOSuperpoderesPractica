import SwiftUI

struct MarvelHeroesView: View {
    @StateObject var marvelHeroesViewModel: MarvelHeroesViewModel
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if let heroes = marvelHeroesViewModel.heroes {
                    ForEach(heroes) { hero in
                        NavigationLink {
                            MarvelHeroesDetailView(hero: hero)
                        } label: {
                            MarvelHeroesRowView(hero: hero)
                        }
                    }//ForEach
                }// iflet
            }// List
        }// NavigationStack
    }// Body
}

struct MarvelHeroesView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelHeroesView(marvelHeroesViewModel: MarvelHeroesViewModel())
    }
}
