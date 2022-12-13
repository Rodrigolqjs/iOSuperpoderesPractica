//
//  FavoriteHeroRowView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 9/12/22.
//

import SwiftUI

struct FavoriteHeroRowView: View {
    var hero: Heroes
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: hero.photo)) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .foregroundColor(.orange)
                    .frame(width: 150, height: 150)
            }
            Text(hero.name)
                .font(.title)
                .padding()
            Spacer()
        }
        .padding()
        Divider()
    }
}

struct FavoriteHeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteHeroRowView(hero: Heroes(id: UUID(), name: "test1", description: "testdesc1", photo: "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg"))
    }
}
