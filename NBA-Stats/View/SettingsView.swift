//
//  SettingsView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = FavoriteTeamViewModel()
    let store = FavoriteStore()
//    @State private var favorite = Team(key: "WAS", city: "Washington", name: "Wizards")
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Favorite Team:")
                .font(.title2)
                .fontWeight(.light)
            
            Picker("Please choose a color", selection: $viewModel.favoriteTeam) {
                ForEach(viewModel.allTeams, id: \.self) { team in
                    Text("\(team.city) \(team.name) ")
                }
            }.pickerStyle(.inline)
            .onChange(of: viewModel.favoriteTeam) { newValue in
                store.setFavorite(teamKeyString: viewModel.favoriteTeam.key)
            }
            
            
            VStack() {
                Text("\(viewModel.favoriteTeam.city) \(viewModel.favoriteTeam.name)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Image(viewModel.favoriteTeam.key)
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 35)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 8, x: 0, y: 0)
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
