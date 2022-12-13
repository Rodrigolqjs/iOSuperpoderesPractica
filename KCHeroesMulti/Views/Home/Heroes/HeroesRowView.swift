//
//  HeroesRowView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 7/12/22.
//

import SwiftUI

struct HeroesRowView: View {
    var hero: Heroes
    
    var body: some View {
        VStack {

            AsyncImage(url: URL(string: hero.photo)) {
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
            
            Text("\(hero.name)")
                .font(.title2)
                .padding([.top, .leading], 10)
            
            if (hero.favorite!) {
                Image(systemName: "heart.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40)
            } else {
                Image(systemName: "heart.circle")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct HeroesRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesRowView(hero: Heroes(id: UUID(), name: "test1", description: "testdesc1", photo: "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg",
            favorite: true))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
    }
}
