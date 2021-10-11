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
    
    init() {
        getStandings(Int(thisYear)!) { result in
            switch result {
            case let .success(allStandings):                
                for standing in allStandings {
                    if standing.conference == "Eastern" {
                        self.easternStandings.append(standing)
                    } else {
                        self.westernStandings.append(standing)
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// Get games by date: You can enter "yesturday", "today", or "tomorrow"
    func getStandings(_ year: Int, completion: @escaping (Result<[Standing]>) -> () ) {
        let fullURL = setParameters(year: year)
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
                    for standing in allStandings {
                        if standing.conference == "Eastern" {
                            self.easternStandings.append(standing)
                        } else {
                            self.westernStandings.append(standing)
                        }
                    }
                }
                
            } catch {
                completion(Result.failure(EndPointError.couldNotParse))
                print(error)
            }
        }.resume()
    }
    
    
    func setParameters(year: Int) -> String {
        return "\(baseURL)\(year)?key=\(apiKey)"
    }
}
