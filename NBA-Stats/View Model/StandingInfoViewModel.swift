//
//  StandingInfoViewModel.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/14/21.
//

import Foundation

class StandingInfoViewModel: ObservableObject {
    @Published var allPlayers = [Player]()
    @Published var firstHalf = [Player]()
    @Published var secondHalf = [Player]()

    let api = APIClient()
    
    init() {
        
    }
    
    func getTeam(teamKeyString: String) {
        api.getAllPlayers(from: teamKeyString) { result in
            switch result {
            case let .success(allPlayers):
                print("Set players")
                self.allPlayers = allPlayers
                print(self.allPlayers.count)
                
                let midPoint = allPlayers.count / 2
                self.firstHalf = Array(allPlayers.prefix(upTo: midPoint)) as Array<Player>
                self.secondHalf = Array(allPlayers.suffix(from: 11)) as Array<Player>
                
                print(self.firstHalf)
                print(self.secondHalf)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
