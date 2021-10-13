//
//  FavoriteTeamViewModel.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/13/21.
//

import UIKit

class FavoriteStore {
    
    var store = UserDefaults.standard
    
    func setFavorite(teamKeyString: String) {
        store.set(teamKeyString, forKey: "favoriteTeam")
    }
    
    func isFavoriteTeam(teamKeyString: String) -> Bool {
        return teamKeyString == store.string(forKey: "favoriteTeam")
    }
}



class FavoriteTeamViewModel: ObservableObject {
    @Published var allTeams = [Team]()
    @Published var favoriteTeam: Team = Team(key: "WAS", city: "Washington", name: "Wizards")
        
    let baseURL = "https://api.sportsdata.io/nba/v2/json/AllTeams"
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    let urlSession = URLSession.shared
    
    init() {
        getAllTeams { result in
            switch result {
            case let .success(allTeams):
                self.allTeams = allTeams
                
                // removing last 2 teams from list: not real teams
                self.allTeams.removeLast()
                self.allTeams.removeLast()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getAllTeams(completion: @escaping (Result<[Team]>) -> () ) {
        let fullURL = setParameters()
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
                let allTeams = try JSONDecoder().decode([Team].self, from: data)
                
                DispatchQueue.main.sync {
                    completion(Result.success(allTeams))
                }
                
            } catch {
                completion(Result.failure(EndPointError.couldNotParse))
                print(error)
            }
        }.resume()
    }
    
    func setParameters() -> String {
        return "\(baseURL)?key=\(apiKey)"
    }
}


