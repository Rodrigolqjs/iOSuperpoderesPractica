//
//  FavoriteDeveloperView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 9/12/22.
//

import SwiftUI

struct FavoriteDeveloperView: View {
    var data: Developer
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(data.heros) { hero in
                    FavoriteHeroRowView(hero: hero)
                }
                
                Spacer()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cerrar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.orange)
                        .cornerRadius(20)
                }

            }
        }
    }
}

struct FavoriteDeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDeveloperView(data: Developer(bootcamp: Bootcamp(id: "", name: ""), id: "", apell1: "", apell2: "", email: "", name: "", photo: "", heros: ViewModelHeroes(testing: true).getHeroesDesing()))
    }
}
