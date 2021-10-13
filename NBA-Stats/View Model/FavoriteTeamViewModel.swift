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
    var store = FavoriteStore()
        
    let baseURL = "https://api.sportsdata.io/nba/v2/json/AllTeams"
    let apiKey = "fe9f2cb9842e40ec8c761e78ecc2c58f"
    let urlSession = URLSession.shared
    let api = APIClient()
    
    init() {
        api.getAllTeams { result in
            switch result {
            case let .success(allTeams):
                self.allTeams = allTeams
                
                for team in self.allTeams {
                    if self.store.isFavoriteTeam(teamKeyString: team.key){
                        self.favoriteTeam = team
                    }
                }
                
                // removing last 2 teams from list: not real teams
                self.allTeams.removeLast()
                self.allTeams.removeLast()
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


