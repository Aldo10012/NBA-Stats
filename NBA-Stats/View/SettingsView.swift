//
//  SettingsView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = FavoriteTeamViewModel()
    
    var body: some View {
        Text("Hello world")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
