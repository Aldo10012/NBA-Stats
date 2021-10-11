//
//  TabBarView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ScoresView()
                .tabItem {
                    Image(systemName: "sportscourt")
                    Text("Scores")
                }
            
            StandingsView()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Standings")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
            
        }.accentColor(.red)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
