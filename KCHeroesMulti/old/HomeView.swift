import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            HeroesView(viewModel: ViewModelHeroes())
                .tabItem {
                    Image(systemName: "house")
                    Text("Heroes")
                }.tag(1)
            
            DevelopersView(viewModel: ViewModelDevelopers())
                .tabItem {
                    Image(systemName: "person")
                    Text("Developers")
                }.tag(2)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
