//
//  StandingsView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct StandingsView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .red
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
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
                                
                HStack() {
                    Text("#")
                        .padding(.leading, 20)
                    Text("Team")
                    Spacer()
                    Text("W  -  L")
                        .padding(.trailing, 20)
                        
                }
                .foregroundColor(Color.gray)
                .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        switch selectedConference {
                        case .western:
                            ForEach(viewModel.westernStandings) { standing in
                                StandingsCellView(standing: standing)
                            }
                        case .eastern:
                            ForEach(viewModel.easternStandings) { standing in
                                StandingsCellView(standing: standing)
                            }
                        }
                    }.padding(.top, 10)
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
