//
//  SettingsView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = FavoriteTeamViewModel()
    @State private var favorite = Team(key: "WAS", city: "Washington", name: "Wizards")
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Favorite Team:")
                .font(.title2)
                .fontWeight(.light)
            
            Picker("Please choose a color", selection: $favorite) {
                ForEach(viewModel.allTeams, id: \.self) { team in
                    Text("\(team.city) \(team.name) ")
                }
            }.pickerStyle(.inline)
            
            
            VStack() {
                Text("\(favorite.city) \(favorite.name)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Image(favorite.key)
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
