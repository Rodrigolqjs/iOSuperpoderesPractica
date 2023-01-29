//
//  MarvelHeroesDetailView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 14/12/22.
//
import SwiftUI

struct MarvelHeroesDetailView: View {
    
    @StateObject var viewModel = MarvelHeroesDetailViewModel()
    var hero: MarvelHeroModel
    
    init(hero: MarvelHeroModel) {
        self.hero = hero
    }
    
    var body: some View {
        switch viewModel.status {
        case .loading:
            let _ = viewModel.getMarvelHeroesSeries(heroId: "\(hero.id)")
        case .loaded:
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        Text("\(hero.name)")
                            .bold()
                            .font(.title)
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                    AsyncImage(url: URL(string: hero.thumbnail.path+".jpg")) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding([.leading, .trailing], 20)
                            .opacity(0.9)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding([.leading, .trailing], 20)
                            .opacity(0.6)
                    }
                    
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            if let series = viewModel.series {
                                LazyHStack {
                                    ForEach(series) { serie in
                                        MarvelHeroesDetailRowView(serie: serie)
                                    }// ForEach
                                }// LazyHStack
                            }// if let
                        } // ScrollView
                    }
                }
            }
        case .error(error: let error):
            ErrorView(error: error)
        }
    }
}

//struct MarvelHeroesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarvelHeroesDetailView(
//            marvelHeroesViewModel: MarvelHeroesViewModel(),
//            hero: MarvelHeroModel(
//                id: 1017833,
//                name: "Ghost Rider (Robbie Reyes)",
//                description: "",
//                thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/1/10/622795c13e687",
//                                     thumbnailExtension: .jpg),
//                comics: Comics(
//                    available: 32,
//                    collectionURI: "http://gateway.marvel.com/v1/public/characters/1017833/comics",
//                    items: [
//                        ComicsItem(
//                            resourceURI: "http://gateway.marvel.com/v1/public/comics/58635",
//                            name: "Ghost Rider X-Mas Special Infinite Comic (2016) #1"
//                        ),
//                        ComicsItem(
//                            resourceURI: "http://gateway.marvel.com/v1/public/comics/67002",
//                            name: "Avengers (2018) #1"
//                        )
//                    ],
//                    returned: 2),
//
//                series: Comics(
//                    available: 17,
//                    collectionURI: "http://gateway.marvel.com/v1/public/characters/1017833/series",
//                    items: [
//                        ComicsItem(
//                            resourceURI: "http://gateway.marvel.com/v1/public/series/24229",
//                            name: "Avengers (2018 - Present)"
//                        ),
//                        ComicsItem(
//                            resourceURI: "http://gateway.marvel.com/v1/public/series/32867",
//                            name: "Avengers Forever (2021 - Present)"
//                        )
//                    ],
//                    returned: 2
//                )
//            )
//        )
//    }
//}
