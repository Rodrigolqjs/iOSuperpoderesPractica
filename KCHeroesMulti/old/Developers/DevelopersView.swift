//
//  DevelopersView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 8/12/22.
//

import SwiftUI

struct DevelopersView: View {
    @StateObject var viewModel: ViewModelDevelopers
    @EnvironmentObject private var viewModelRoot: RootViewModel
    @State private var selectedDev: Developer? = nil
    
    var body: some View {
        ScrollView {
            
            if let bootcamps = viewModelRoot.bootcamps,
               let developers = viewModel.developers {
                
                ForEach(bootcamps) { bootcamp in
                    
                    let dataFilter = viewModel.getDevelopersBootcamps(id: bootcamp.id)
                    
                    if dataFilter.count > 0 {
                        VStack(alignment: .leading) {
                            
                            Text(bootcamp.name)
                                .font(.title)
                                .foregroundColor(.orange)
                                .bold()
                            
                            ScrollView(.horizontal, showsIndicators: true) {
                                LazyHStack {
                                    ForEach(dataFilter) { developer in
                                        DeveloperRowView(developer: developer)
                                            .onTapGesture(count: 2) {
                                                // Mostrar Modal
                                                selectedDev = developer
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Text("Sin datos")
            }
        }
        .sheet(item: self.$selectedDev) { developer in
            FavoriteDeveloperView(data: developer)
        }
    }
}

struct DevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        let rootvm = RootViewModel(testing: true)
        
        DevelopersView(viewModel: ViewModelDevelopers(testing: true, bootcamps: rootvm.bootcamps!))
            .environmentObject(rootvm)
    }
}
