//
//  Standings.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import Foundation

/*
What is needed?

Taem Name
Team Logo
Team winnings
Team losses
*/

struct Standing: Codable, Identifiable {
    var id = UUID()
    
    var name: String  { didSet {logo = setTeamLogo(from: name)} }
    var logo: String = ""
    let wins: Int
    let losses: Int
    let conference: String
    
    enum CodingKeys: String, CodingKey {
        case logo
        case name = "Key"
        case wins = "Wins"
        case losses = "Losses"
        case conference = "Conference"
    }
}

extension Standing {
    
    /// return the team logo url based on the team name
    func setTeamLogo(from teamName: String) -> String {
        switch teamName {
        case "WAS": return "https://upload.wikimedia.org/wikipedia/en/0/02/Washington_Wizards_logo.svg"
        case "CHA": return "https://upload.wikimedia.org/wikipedia/en/c/c4/Charlotte_Hornets_%282014%29.svg"
        case "ATL": return "https://upload.wikimedia.org/wikipedia/en/2/24/Atlanta_Hawks_logo.svg"
        case "MIA": return "https://upload.wikimedia.org/wikipedia/en/f/fb/Miami_Heat_logo.svg"
        case "ORL": return "https://upload.wikimedia.org/wikipedia/en/1/10/Orlando_Magic_logo.svg"
        case "NY":  return "https://upload.wikimedia.org/wikipedia/en/2/25/New_York_Knicks_logo.svg"
        case "PHI": return "https://upload.wikimedia.org/wikipedia/en/0/0e/Philadelphia_76ers_logo.svg"
        case "BKN": return "https://upload.wikimedia.org/wikipedia/commons/4/44/Brooklyn_Nets_newlogo.svg"
        case "BOS": return "https://upload.wikimedia.org/wikipedia/en/8/8f/Boston_Celtics.svg"
        case "TOR": return "https://upload.wikimedia.org/wikipedia/en/3/36/Toronto_Raptors_logo.svg"
        case "CHI": return "https://upload.wikimedia.org/wikipedia/en/6/67/Chicago_Bulls_logo.svg"
        case "CLE": return "https://upload.wikimedia.org/wikipedia/en/4/4b/Cleveland_Cavaliers_logo.svg"
        case "IND": return "https://upload.wikimedia.org/wikipedia/en/1/1b/Indiana_Pacers.svg"
        case "DET": return "https://upload.wikimedia.org/wikipedia/commons/7/7c/Pistons_logo17.svg"
        case "MIL": return "https://upload.wikimedia.org/wikipedia/en/4/4a/Milwaukee_Bucks_logo.svg"
        case "MIN": return "https://upload.wikimedia.org/wikipedia/en/c/c2/Minnesota_Timberwolves_logo.svg"
        case "UTA": return "https://upload.wikimedia.org/wikipedia/en/0/04/Utah_Jazz_logo_%282016%29.svg"
        case "OKC": return "https://upload.wikimedia.org/wikipedia/en/5/5d/Oklahoma_City_Thunder.svg"
        case "POR": return "https://upload.wikimedia.org/wikipedia/en/2/21/Portland_Trail_Blazers_logo.svg"
        case "DEN": return "https://upload.wikimedia.org/wikipedia/en/7/76/Denver_Nuggets.svg"
        case "MEM": return "https://upload.wikimedia.org/wikipedia/en/f/f1/Memphis_Grizzlies.svg"
        case "HOU": return "https://upload.wikimedia.org/wikipedia/en/2/28/Houston_Rockets.svg"
        case "NO":  return "https://upload.wikimedia.org/wikipedia/en/0/0d/New_Orleans_Pelicans_logo.svg"
        case "SA":  return "https://upload.wikimedia.org/wikipedia/en/a/a2/San_Antonio_Spurs.svg"
        case "DAL": return "https://upload.wikimedia.org/wikipedia/en/9/97/Dallas_Mavericks_logo.svg"
        case "GS":  return "https://upload.wikimedia.org/wikipedia/en/0/01/Golden_State_Warriors_logo.svg"
        case "LAL": return "https://upload.wikimedia.org/wikipedia/commons/3/3c/Los_Angeles_Lakers_logo.svg"
        case "LAC": return "https://upload.wikimedia.org/wikipedia/en/b/bb/Los_Angeles_Clippers_%282015%29.svg"
        case "PHO": return "https://upload.wikimedia.org/wikipedia/en/d/dc/Phoenix_Suns_logo.svg"
        case "SAC": return "https://upload.wikimedia.org/wikipedia/en/c/c7/SacramentoKings.svg"
        default:
            print("error")
            return "error"
        }
    }
}
