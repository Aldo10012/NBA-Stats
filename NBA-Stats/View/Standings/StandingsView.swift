//
//  StandingsView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct StandingsView: View {
    
    @ObservedObject var viewModel = StandingsViewModel()
    @State private var selectedConference: SelectedConference = .western 
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose a day", selection: $selectedConference) {
                    ForEach(SelectedConference.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Text(selectedConference.rawValue)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.westernStandings) { standing in
                            StandingsCellView(standing: standing)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Standings")
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
    }
}

enum SelectedConference: String, CaseIterable {
    case western = "Western"
    case eastern = "Eastern"
}
