//
//  HeroesDetailView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 8/12/22.
//

import SwiftUI

struct HeroesDetailView: View {
    
    @ObservedObject var viewModelHeroes: ViewModelHeroes
    
    var hero: Heroes
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    Text("\(hero.name)")
                        .bold()
                        .font(.title)
                    
                    Spacer()
                    
                    Button {
                        //action
                        viewModelHeroes.callToLike(idHero: hero.id.uuidString)
                    } label: {
                        if (hero.favorite!) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }

                }
                .padding([.leading, .trailing], 20)
//                Spacer()
                AsyncImage(url: URL(string: hero.photo)) { img in
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
                
                Text("\(hero.description)")
                    .foregroundColor(.black)
                    .font(.caption)
                    .padding(20)
            }
        }
    }
}

struct HeroesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesDetailView(viewModelHeroes: ViewModelHeroes(), hero: Heroes(id: UUID(), name: "test1", description: "testdesc1", photo: "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg", favorite: true))
    }
         
         
}


/*
ZStack {
    AsyncImage(url: URL(string: hero.photo)) { img in
        img
            .resizable()
            .cornerRadius(20)
            .padding([.leading, .trailing], 2)
            .opacity(0.9)
        
    } placeholder: {
        //imagen hasta que se descarge
        Image(systemName: "photo")
            .resizable()
            .cornerRadius(20)
            .padding([.leading, .trailing], 2)
            .opacity(0.9)
    }
    
    VStack {
        HStack{
            Text("\(hero.name)")
                .font(.title)
                .bold()
                .padding([.top, .leading], 10)
            Spacer()
        }
        if (hero.favorite!) {
            Image(systemName: "heart.circle")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 40, height: 40)
                .padding([.leading, .trailing], 10)
        } else {
            Image(systemName: "heart.circle")
                .resizable()
        }
    }
    
}
*/
