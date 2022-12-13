//
//  DeveloperRowView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 8/12/22.
//

import SwiftUI

struct DeveloperRowView: View {
    var developer: Developer
    
    var body: some View {
        VStack {
            //Foto
            AsyncImage(url: URL(string: developer.photo)) { Image in
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

            //Nombre y apellido
            Text("\(developer.name) \(developer.apell1)")
                .font(.caption)
                .foregroundColor(.orange)
        }
    }
}

struct DeveloperRowView_Previews: PreviewProvider {
    static var previews: some View {
        let b1 = Bootcamp(id: "01", name: "Bootcamp X")
        let dev1 = Developer(bootcamp: b1, id: "100", apell1: "Latorre", apell2: "Quispe", email: "rodrigo.latorre.quispe@gmail.com", name: "Rodrigo", photo: "https://cdn-employer-wp.arc.dev/wp-content/uploads/2022/04/good-software-developer-1128x635.jpg", heros: [])
        
        DeveloperRowView(developer: dev1)
    }
}
