//
//  MarvelHeroesDetailRowView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 28/01/23.
//

import SwiftUI

struct MarvelHeroesDetailRowView: View {
    var serie: HeroSeriesModel
    
    init(serie: HeroSeriesModel) {
        self.serie = serie
        print("se llamo")
    }
    var body: some View {
        VStack{
            //foto
            AsyncImage(url: URL(string: serie.urlPath)) { Image in
                Image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
            }

            //nombre y apellido 1
            Text(serie.title)
                .font(.caption)
                .foregroundColor(.orange)
            
        }
        
    }
}
