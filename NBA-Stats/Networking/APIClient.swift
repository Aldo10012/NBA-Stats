//
//  APIClient.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/13/21.
//

import Foundation

class APIClient {
    let gamesByDateBaseURL = "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/"
    let standingsBaseURL = "https://api.sportsdata.io/v3/nba/scores/json/Standings/"
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    let urlSession = URLSession.shared
    
    //MARK: - GamesByDate

    /// Get games by date: You can enter "yesturday", "today", or "tomorrow"
    func getGamesByDate(_ date: String, completion: @escaping (Result<[String: [GameByDate] ]>) -> () ) {
        let fullURL = setGamesByDateParams(date: date)
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
                    var foobar = [String: [GameByDate] ]()
                    
                    switch date {
                    case yesterday: foobar["yesterday"] = games
                    case today:     foobar["today"]     = games
                    case tomorrow:  foobar["tomorrow"]  = games
                    default:
                        print("error")
                    }
                    
                    completion(Result.success(foobar))
                }
                
            } catch {
                completion(Result.failure(EndPointError.couldNotParse))
                print(error)
            }
        }.resume()
    }
    
    
    func setGamesByDateParams(date: String) -> String {
        return "\(gamesByDateBaseURL)\(date)?key=\(apiKey)"
    }
    
    
    // MARK: - Standings
    
    /// Get games by date: You can enter "yesturday", "today", or "tomorrow"
    func getStandings(_ year: Int, completion: @escaping (Result<[String: [Standing]]>) -> () ) {
        let fullURL = setStandingsParams(year: year)
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
                let allStandings = try JSONDecoder().decode([Standing].self, from: data)
                
                DispatchQueue.main.sync {
                    var foobar: [String: [Standing]] = [
                        "easternStandings": [Standing](),
                        "westernStandings": [Standing]()
                    ]
                    
                    for standing in allStandings {
                        if standing.conference == "Eastern" {
                            foobar["easternStandings"]!.append(standing)
                        } else {
                            foobar["westernStandings"]!.append(standing)
                        }
                    }
                    
                    completion(Result.success(foobar))
                }
                
            } catch {
                completion(Result.failure(EndPointError.couldNotParse))
                print(error)
            }
        }.resume()
    }
    
    
    func setStandingsParams(year: Int) -> String {
        return "\(standingsBaseURL)\(year)?key=\(apiKey)"
    }
    
    
    
    
}
