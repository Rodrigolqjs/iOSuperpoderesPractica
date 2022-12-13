//
//  ErrorView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import SwiftUI

struct ErrorView: View {
    
    @EnvironmentObject var viewModel: RootViewModel
    
    private var textError: String
    init(error: String) {
        textError = error
    }
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "exclamationmark.bubble")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 200, height: 200)
                .padding()
            Text(textError)
                .foregroundColor(.red)
                .font(.headline)
            Spacer()
            Button {
                viewModel.status = .none
            } label: {
                Text("Volver al Login")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.orange)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 10, y: 10)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error")
    }
}
