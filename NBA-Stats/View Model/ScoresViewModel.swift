//
//  ScoresViewModel.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import Foundation

class ScoresViewModel: ObservableObject {
    @Published var yesturdaysGames = [GameByDate]()
    @Published var todaysGames = [GameByDate]()
    @Published var tomorrowsGames = [GameByDate]()
    
    let baseURL = "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/"
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    let urlSession = URLSession.shared
    let api = APIClient()
    
    init() {
        api.getGamesByDate(yesterday) { result in
            switch result {
            case let .success(games):
                print("Set yesturdays games")
                self.yesturdaysGames = games["yesterday"]!
            case let .failure(error):
                print(error)
            }
        }
        
        api.getGamesByDate(today) { result in
            switch result {
            case let .success(games):
                print("Set todays games")
                self.todaysGames = games["today"]!
            case let .failure(error):
                print(error)
            }
        }
        
        api.getGamesByDate(tomorrow) { result in
            switch result {
            case let .success(games):
                print("Set tomorrows games")
                self.tomorrowsGames = games["tomorrow"]!
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
