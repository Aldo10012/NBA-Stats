//
//  FavoriteTeamViewModel.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/13/21.
//

import UIKit

class FavoriteTeamViewModel: ObservableObject {
    @Published var favoriteTeam: String
    
    init() {
        self.favoriteTeam = ""
    }
}
