//
//  HeroesRowView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 7/12/22.
//

import SwiftUI

struct MarvelHeroesRowView: View {
    var hero: MarvelHeroModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: hero.thumbnail.path+".jpg")) {
                photo in
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
            }
            .id("ImageRow")
            
            Text("\(hero.name)")
                .font(.title2)
                .padding([.top, .leading], 10)
                .id("TextRow")
        }
    }
}

//struct HeroesRowView_Previews: PreviewProvider {
//    static var previews: some View {
////        HeroesRowView(hero: nil))
//    }
//}
