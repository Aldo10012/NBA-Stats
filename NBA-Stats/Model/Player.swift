//
//  Player.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/14/21.
//

import Foundation

struct Player: Codable, Identifiable {
    var id = UUID()
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName  = "FirstName"
        case lastName = "LastName"
    }
}
