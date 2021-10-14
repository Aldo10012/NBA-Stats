//
//  StandingInfoView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/14/21.
//

import SwiftUI

struct StandingInfoView: View {
    
    @State var standing: Standing
    @ObservedObject var viewModel = StandingInfoViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                StandingInfoHeaderView(standing: standing)
                
                StandingInfoRowView(labelOne: "Conference\nWins", detailOne: standing.conferenceWins,
                                    labelTwo: "Conference\nLosses", detailTwo: standing.conferenceLosses,
                                    labelThree: "Conference\nWin Rate")
                            
                StandingInfoRowView(labelOne: "Home\nWins", detailOne: standing.homeWins,
                                    labelTwo: "Home\nLosses", detailTwo: standing.homeLosses,
                                    labelThree: "Home\nWin Rate")
                
                StandingInfoRowView(labelOne: "Away\nWins", detailOne: standing.awayWins,
                                    labelTwo: "Away\nLosses", detailTwo: standing.awayLosses,
                                    labelThree: "Away\nWin Rate")
                
                VStack(spacing: 20) {
                    
                    Text("Players")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        
                    
                    HStack(alignment: .top ,spacing: 25) {
                        VStack(spacing: 10) {
                            ForEach (viewModel.firstHalf) { player in
                                Text(player.firstName + player.lastName)
                            }
                        }.frame(maxWidth: .infinity)
                        
                        VStack(spacing: 10) {
                            ForEach (viewModel.secondHalf) { player in
                                Text(player.firstName + " " + player.lastName)
                            }
                        }.frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(16)
                .frame(width: UIScreen.main.bounds.size.width-32)
                .foregroundColor(Color(UIColor.label))
                .background(Color("OffColor"))
                .cornerRadius(16)
                
                Spacer()
            }.onAppear {
                viewModel.getTeam(teamKeyString: standing.key)
        }
        }
    }
}

struct StandingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StandingInfoView(standing: sampleStanding)
    }
}

struct StandingInfoHeaderView: View {
    
    @State var standing: Standing
    
    var body: some View {
        HStack(spacing: 20) {
            Image(standing.key)
                .resizable()
                .frame(width: 125, height: 125)
                .aspectRatio(contentMode: .fill)
            
            VStack(alignment: .leading) {
                Text(standing.city)
                    .fontWeight(.semibold)
                Text(standing.name)
                    .fontWeight(.semibold)
            }
            .font(.largeTitle)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(alignment: .leading)
    }
}

struct StandingInfoRowView: View {
        
    @State var labelOne: String
    @State var detailOne: Int
    
    @State var labelTwo: String
    @State var detailTwo: Int
    
    @State var labelThree: String
    
    @State var winRatio: Double = 0.0
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 15) {
                Text(labelOne)
                    .multilineTextAlignment(.center)
                
                Text("\(detailOne)")
                    .font(.title3)
                    .fontWeight(.bold)
            }.frame(maxWidth: .infinity)
            
            VStack(spacing: 15) {
                Text(labelTwo)
                    .multilineTextAlignment(.center)
                
                Text("\(detailTwo)")
                    .font(.title3)
                    .fontWeight(.bold)
            }.frame(maxWidth: .infinity)
            
            VStack(spacing: 15) {
                Text(labelThree)
                    .multilineTextAlignment(.center)
                
                Text("\(String(format: "%.2f", winRatio))%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .onAppear {
                        detailThree()
                    }
            }.frame(maxWidth: .infinity)
        }
        .padding(16)
        .frame(width: UIScreen.main.bounds.size.width-32)
        .foregroundColor(Color(UIColor.label))
        .background(Color("OffColor"))
        .cornerRadius(16)
    }
    
    private func detailThree() -> Double {
        let win = Double(detailOne)
        let loss = Double(detailTwo)
        
        winRatio = win / (win + loss)
        winRatio *= 100
        winRatio = round(winRatio * 100) / 100.0
                
        return winRatio
    }
    
}
