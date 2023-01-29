//
//  ModalDescView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 29/01/23.
//

import SwiftUI

struct ModalDescView: View {
    
    @Binding var isShowing: Bool
    @Binding var serie: [HeroSeriesModel]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                VStack {
                    Text(serie[0].title)
                        .font(.title2)
                    Text(serie[0].desc ?? "")
                        .padding([.leading, .trailing])
                }
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .transition(.move(edge: .bottom))
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeOut)
    }
}

struct ModalDescView_Previews: PreviewProvider {
    static var previews: some View {
        ModalDescView(isShowing: .constant(true), serie: .constant([HeroSeriesModel(id: 1, title: "title", desc: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", urlPath: "path")]))
    }
}
