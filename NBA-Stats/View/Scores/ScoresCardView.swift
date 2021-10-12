//
//  ScoresCardView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct ScoresCardView: View {
    
    @State var game: GameByDate
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 40) {
                InfoColumnView(logo: game.homeTeamLogo,
                              name: game.homeTeam,
                              score: game.homeTeamScore
                )
                
                Text("VS")
                
                InfoColumnView(logo: game.awayTeamLogo,
                              name: game.awayTeam,
                              score: game.awayTeamScore
                )
            }
            
            Text(game.status)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 50)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 8, x: 4, y: 4)
        .onAppear {
            print(game)
        }
        
    }
}

struct ScoresCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresCardView(game: tempGame)
    }
}


struct InfoColumnView: View {
    
    @State var logo: String
    @State var name: String
    @State var score: Int?
    
    var body: some View {
        VStack(spacing: 15) {
            Image(uiImage: logo.load())
                .resizable()
                .frame(width: 80, height: 100)
                .aspectRatio(contentMode: .fill)
                .background(Color(UIColor.lightGray))
            Text(name)
            if let score = score {
                Text(String( score ?? 0 ))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .offset(y: -15)
            } else {
                Text("-")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .offset(y: -15)
            }
        }
    }
}
