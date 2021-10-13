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
    
    var body: some View {
        HStack {
            Image(standing.key)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.leading)
                
            // if is favorite
            if favoritesStore.isFavoriteTeam(teamKeyString: standing.key) {
                Text("\(standing.city) \(standing.name)")
                    .foregroundColor(Color(UIColor.black))
                    .padding()
                
                Spacer()
                
                Text("\(standing.wins) - \(standing.losses)")
                    .foregroundColor(Color(UIColor.black))
                    .padding()
            }
            else {
                Text("\(standing.city) \(standing.name)")
                    .padding()

                Spacer()
                
                Text("\(standing.wins) - \(standing.losses)")
                    .padding()
            }
            
        }
        .frame(height: 60)
        .background(Color(favoritesStore.isFavoriteTeam(teamKeyString: standing.key) ? UIColor.yellow : UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color(UIColor.lightGray), radius: 4, x: 2, y: 0)
        .padding(.horizontal)
        .onAppear {
            
        }
    }
}

struct StandingsCellView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsCellView(standing: sampleStanding)
    }
}

let sampleStanding = Standing(key: "NY", city: "New York", name: "Knicks", wins: 20, losses: 25, conference: "Eastern")
