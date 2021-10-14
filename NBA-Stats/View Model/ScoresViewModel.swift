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
                
                for i in 0..<self.yesturdaysGames.count {
                    self.yesturdaysGames[i].dateTime = self.fixTimeLabel(self.yesturdaysGames[i].dateTime)
                }
                
            case let .failure(error):
                print(error)
            }
        }
        
        api.getGamesByDate(today) { result in
            switch result {
            case let .success(games):
                print("Set todays games")
                self.todaysGames = games["today"]!
                
                for i in 0..<self.todaysGames.count {
                    self.todaysGames[i].dateTime = self.fixTimeLabel(self.todaysGames[i].dateTime)
                }
                
            case let .failure(error):
                print(error)
            }
        }
        
        api.getGamesByDate(tomorrow) { result in
            switch result {
            case let .success(games):
                print("Set tomorrows games")
                self.tomorrowsGames = games["tomorrow"]!
                
                for i in 0..<self.tomorrowsGames.count {
                    self.tomorrowsGames[i].dateTime = self.fixTimeLabel(self.tomorrowsGames[i].dateTime)
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func fixTimeLabel(_ foobar: String) -> String {
        
        var date = foobar
        for i in 0..<11 { date.removeFirst() }
        for i in 0..<3 { date.removeLast() }
        
        let end = date.firstIndex(of: ":")!
        let hour = String(date[..<end])
        let minute = String(date[end...])
        
        if Int(hour)! < 12 {
            return hour + minute + " AM"
        }
        else if Int(hour)! == 12 {
            return hour + minute + " PM"
        }
        else if Int(hour)! == 24 {
            return String(Int(hour)!-12) + minute + " AM"
        }
        else {
            return String(Int(hour)!-12) + minute + " PM"
        }
        
        
    }
    
}
