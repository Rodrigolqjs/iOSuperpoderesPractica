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
    }
    var body: some View {
        VStack{
            Spacer()
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
            Text(serie.title)
                .font(.caption)
                .foregroundColor(.orange)
//            if let desc = serie.desc {
//                Button("Ver descripcion") {
//                    ModalDescView(isShowing: true, description: desc)
//                }
//                .frame(width: 100, height: 50)
//            }
        }
    }
}

struct MarvelHeroesDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelHeroesDetailRowView(serie: HeroSeriesModel(id: 123, title: "titletest", desc: "fast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfasfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfasfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfast descfas", urlPath: "noupath"))
    }
}

