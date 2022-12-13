import SwiftUI

struct HeroesView: View {
    @StateObject var viewModel: ViewModelHeroes
    @State private var filter: String = ""
    @EnvironmentObject private var rootViewModel: RootViewModel
    var body: some View {
        NavigationStack {
//        NavigationView {
            List {
                if let heroes = viewModel.heroes {
                    ForEach(heroes) { hero in
                        NavigationLink {
                            HeroesDetailView(viewModelHeroes: viewModel, hero: hero)
                        } label: {
                            HeroesRowView(hero: hero)
                        }

                    }
                }
            }
            .searchable(text: $filter, prompt: "Buscar heroe...")
            .onChange(of: filter, perform: { newValue in
                viewModel.getHeroes(filter: newValue)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        rootViewModel.closeSession()
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text("Cerrar sesión")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }

                }

            }
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView(viewModel: ViewModelHeroes(testing: true))
    }
}
