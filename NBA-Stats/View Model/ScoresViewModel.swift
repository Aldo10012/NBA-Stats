//
//  ScoresViewModel.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import Foundation

class ScoresViewModel: ObservableObject {
    @Published var games = [GameByDate]()

    @Published var yesturdaysGames = [GameByDate]()
    @Published var todaysGames = [GameByDate]()
    @Published var tomorrowsGames = [GameByDate]()
    
    let baseURL = "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/"
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    let urlSession = URLSession.shared
    
    init() {
        getGamesByDate(today) { result in
            switch result {
            case let .success(games):
                self.games = games
            case let .failure(error):
                print(error)
            }
        }
        
        getGamesByDate(yesterday) { result in
            switch result {
            case let .success(games):
                self.yesturdaysGames = games
            case let .failure(error):
                print(error)
            }
        }
        
        getGamesByDate(today) { result in
            switch result {
            case let .success(games):
                self.todaysGames = games
            case let .failure(error):
                print(error)
            }
        }
        getGamesByDate(tomorrow) { result in
            switch result {
            case let .success(games):
                self.tomorrowsGames = games
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// Get games by date: You can enter "yesturday", "today", or "tomorrow"
    func getGamesByDate(_ date: String, completion: @escaping (Result<[GameByDate]>) -> () ) {
        let fullURL = setParameters(date: date)
        guard let url = URL(string: fullURL) else {return}
        let request = URLRequest(url: url)
        
        urlSession.dataTask(with: request) { data, responce, error in
            if let error = error {
                return completion(Result.failure(error))
            }
            
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            
            do {
                let games = try JSONDecoder().decode([GameByDate].self, from: data)
                
                DispatchQueue.main.sync {
                    self.games = games
                    if date == yesterday{
                        self.yesturdaysGames = games
                    }
                    if date == today {
                        self.todaysGames = games
                    }
                    if date == tomorrow {
                        self.tomorrowsGames = games
                    }
                }
                
            } catch {
                completion(Result.failure(EndPointError.couldNotParse))
                print(error)
            }
        }.resume()
    }
    
    
    func setParameters(date: String) -> String {
        return "\(baseURL)\(date)?key=\(apiKey)"
    }
}
