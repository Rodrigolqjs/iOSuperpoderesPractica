//
//  MarvelHeroesDetailView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 14/12/22.
//
import SwiftUI

struct MarvelHeroesDetailView: View {
    
    @StateObject var viewModel = MarvelHeroesDetailViewModel()
    @State var showModal: Bool = false
    @State var sendSerie: [HeroSeriesModel] = []
    var hero: MarvelHeroModel
    
    init(hero: MarvelHeroModel) {
        self.hero = hero
    }
    
    var body: some View {
        switch viewModel.status {
        case .loading:
            let _ = viewModel.getMarvelHeroesSeries(heroId: "\(hero.id)")
        case .loaded:
//                ScrollView(.vertical) {
            ZStack {
                VStack {
                    HStack {
                        Text("\(hero.name)")
                            .bold()
                            .font(.title)
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                    AsyncImage(url: URL(string: (hero.thumbnail.path)+".jpg")) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding([.leading, .trailing], 5)
                            .opacity(0.9)
                            .frame(height: 500)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding([.leading, .trailing], 5)
                            .opacity(0.6)
                            .frame(height: 500)
                            .frame(maxWidth: .infinity)
                    }

                    VStack(alignment: .center) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            if let series = viewModel.series {
                                LazyHStack {
                                    ForEach(series) { serie in
                                        MarvelHeroesDetailRowView(serie: serie)
                                            .onTapGesture {
                                                sendSerie = []
                                                showModal = true
                                                sendSerie.append(serie)
                                            }
                                    }// ForEach
                                }// LazyHStack
                            }// if let
                        } // ScrollView
                    }
                }//
                ModalDescView(isShowing: $showModal, serie: $sendSerie)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                }
        case .error(error: let error):
            ErrorView(error: error)
        }
    }
}
