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
        api.getStandings(Int(thisYear)!) { result in
            switch result {
            case let .success(allStandings):
                print("added standings")
                self.westernStandings = allStandings["westernStandings"]!
                self.easternStandings = allStandings["easternStandings"]!
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
