//
//  StandingsCellView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct StandingsCellView: View {
    
    @State var standing: Standing
    let favoritesStore = FavoriteStore()
    @State var textColor: Color = .green
    @State var bgColor: Color = .green
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(standing.ranking)")
                .foregroundColor(textColor)
                .padding(.leading)
            
            Image(standing.key)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text("\(standing.city) \(standing.name)")
                .foregroundColor(textColor)
            
            Spacer()
            
            Text("\(standing.wins) - \(standing.losses)")
                .foregroundColor(textColor)
                .padding(.trailing)
        }
        .frame(height: 60)
        .background(bgColor)
        .cornerRadius(8)
        .shadow(color: Color(UIColor.lightGray), radius: 4, x: 2, y: 0)
        .padding(.horizontal)
        .onAppear {
            if favoritesStore.isFavoriteTeam(teamKeyString: standing.key) {
                textColor = Color(UIColor.black)
                bgColor = Color(UIColor.yellow)
            } else {
                textColor = Color(UIColor.label)
                bgColor = Color(UIColor.systemBackground)
            }
        }
    }
}

struct StandingsCellView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsCellView(standing: sampleStanding)
    }
}

let sampleStanding = Standing(
    key: "NY",
    city: "New York",
    name: "Knicks",
    wins: 20,
    losses: 25,
    percentage: 0.52,
    ranking: 1,
    conference: "Eastern",
    conferenceWins: 10,
    conferenceLosses: 12,
    homeWins: 10,
    homeLosses: 12,
    awayWins: 10,
    awayLosses: 12
)
