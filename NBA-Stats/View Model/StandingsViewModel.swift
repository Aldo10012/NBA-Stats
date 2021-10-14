//
//  StandingsViewModel.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import Foundation

class StandingsViewModel: ObservableObject {
    @Published var westernStandings = [Standing]()
    @Published var easternStandings = [Standing]()
    
    let baseURL = "https://api.sportsdata.io/v3/nba/scores/json/Standings/"
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    let urlSession = URLSession.shared
    let api = APIClient()
    
    init() {
        api.getStandings(Int(thisYear)!) { [self] result in
            switch result {
            case let .success(allStandings):
                print("added standings")
                
                self.westernStandings = allStandings["westernStandings"]!.sorted(by:{ $0.percentage > $1.percentage })
                
                for i in 0..<self.westernStandings.count {
                    self.westernStandings[i].ranking = i+1
                }
                
                self.easternStandings = allStandings["easternStandings"]!.sorted(by:{ $0.percentage > $1.percentage })
                for i in 0..<self.easternStandings.count {
                    self.easternStandings[i].ranking = i+1
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
