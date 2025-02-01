//
//  APIClient.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/13/21.
//

import Foundation
import EZNetworking

enum APIEndpoint {
    case gamesByDateBaseURL
    case standingsBaseURL
    case allTeamsBaseURL
    case allPlayersBaseURL
    
    var url: String {
        return switch self {
        case .gamesByDateBaseURL:
            "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/"
        case .standingsBaseURL:
            "https://api.sportsdata.io/v3/nba/scores/json/Standings/"
        case .allTeamsBaseURL:
            "https://api.sportsdata.io/nba/v2/json/AllTeams"
        case .allPlayersBaseURL:
            "https://api.sportsdata.io/nba/v2/json/Players/"
        }
    }
}

class APIClient {
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    
    let performer = RequestPerformer()
    
    //MARK: - GamesByDate

    /// Get games by date: You can enter "yesterday", "today", or "tomorrow"
    func getGamesByDate(_ date: String, completion: @escaping (Result<[String: [GameByDate] ]>) -> () ) {
        let request = RequestFactoryImpl()
            .build(httpMethod: .GET,
                   baseUrlString: "\(APIEndpoint.gamesByDateBaseURL.url)\(date)",
                   parameters: [.init(key: "key", value: apiKey)]
            )
        
        performer.performTask(request: request, decodeTo: [GameByDate].self) { result in
            switch result {
            case .success(let games):
                var foobar = [String: [GameByDate] ]()
                switch date {
                case yesterday: foobar["yesterday"] = games
                case today:     foobar["today"]     = games
                case tomorrow:  foobar["tomorrow"]  = games
                default:
                    print("error")
                }
                DispatchQueue.main.sync {
                    completion(Result.success(foobar))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("DEBUG: ", error)
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    // MARK: - Standings
    
    /// Get games by date: You can enter "yesterday", "today", or "tomorrow"
    func getStandings(_ year: Int, completion: @escaping (Result<[String: [Standing]]>) -> () ) {
        let request = RequestFactoryImpl()
            .build(httpMethod: .GET,
                   baseUrlString: "\(APIEndpoint.standingsBaseURL.url)\(year)",
                   parameters: [.init(key: "key", value: apiKey)]
            )
        
        performer.performTask(request: request, decodeTo: [Standing].self) { result in
            switch result {
            case .success(let allStandings):
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
                
                DispatchQueue.main.sync {
                    completion(Result.success(foobar))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("DEBUG: ", error)
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    // MARK: - All teams
    
    func getAllTeams(completion: @escaping (Result<[Team]>) -> () ) {
        let request = RequestFactoryImpl()
            .build(httpMethod: .GET,
                   baseUrlString: "\(APIEndpoint.allTeamsBaseURL.url)",
                   parameters: [.init(key: "key", value: apiKey)]
            )
        
        performer.performTask(request: request, decodeTo: [Team].self) { result in
            switch result {
            case .success(let allTeams):
                DispatchQueue.main.sync {
                    completion(Result.success(allTeams))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("DEBUG: ", error)
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    // MARK: - Players
    
    func getAllPlayers(from team: String, completion: @escaping (Result<[Player]>) -> () ) {
        let request = RequestFactoryImpl()
            .build(httpMethod: .GET,
                   baseUrlString: "\(APIEndpoint.allPlayersBaseURL.url)\(team)",
                   parameters: [.init(key: "key", value: apiKey)]
            )
        
        performer.performTask(request: request, decodeTo: [Player].self) { result in
            switch result {
            case .success(let allPlayers):
                DispatchQueue.main.sync {
                    completion(Result.success(allPlayers))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("DEBUG: ", error)
                    completion(Result.failure(error))
                }
            }
        }
    }
}
