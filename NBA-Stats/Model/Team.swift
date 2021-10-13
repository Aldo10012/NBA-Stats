//
//  AllTeams.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/13/21.
//

import Foundation

struct Team: Codable, Identifiable, Hashable {
    
    var id = UUID()
    
    let key: String
    let city: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case key  = "Key"
        case city = "City"
        case name = "Name"
    }
}


