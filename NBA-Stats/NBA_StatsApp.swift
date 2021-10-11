//
//  NBA_StatsApp.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

@main
struct NBA_StatsApp: App {
    var body: some Scene {
        WindowGroup {
            ScoresCardView(game: tempGame)
        }
    }
}
