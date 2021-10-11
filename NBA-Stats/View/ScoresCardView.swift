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
            HStack(spacing: 25) {
                VStack(spacing: 15) {
                    Image(uiImage: game.homeTeamLogo.load())
                        .resizable()
                        .frame(width: 80, height: 100)
                        .aspectRatio(contentMode: .fill)
                    Text(game.homeTeam)
                    Text(String( game.homeTeamScore ?? 0 ))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .offset(y: -15)
                }
                
                Text("VS")
                
                VStack(spacing: 15) {
                    Image(uiImage: game.awayTeamLogo.load())
                        .resizable()
                        .frame(width: 80, height: 100)
                        .aspectRatio(contentMode: .fill)
                    Text(game.awayTeam)
                    Text(String( game.awayTeamScore ?? 0 ))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .offset(y: -15)
                }
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








