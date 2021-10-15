//
//  ContentView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct ScoresView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .red
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    @ObservedObject var viewModel = ScoresViewModel()
    @State private var selectedDate: SelectedDate = .today
    
    var body: some View {
        NavigationView {
            VStack {
                
                Picker("Choose a day", selection: $selectedDate) {
                    ForEach(SelectedDate.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        switch selectedDate {
                        case .yesterday:
                            if viewModel.yesterdaysGames.count != 0 {
                                ForEach(viewModel.yesterdaysGames) { game in
                                    ScoresCardView(game: game)
                                }
                            } else {
                                Text("No games today")
                            }
                            
                            
                        case .today:
                            if viewModel.todaysGames.count != 0 {
                                ForEach(viewModel.todaysGames) { game in
                                    ScoresCardView(game: game)
                                }
                            } else {
                                Text("No games today")
                            }
                            
                            
                        case .tomorrow:
                            if viewModel.tomorrowsGames.count != 0 {
                                ForEach(viewModel.tomorrowsGames) { game in
                                    ScoresCardView(game: game)
                                }
                            } else {
                                Text("No games today")
                            }
                            
                            
                        }
                    }.padding(.top, 10)
                }
                
                Spacer()
            }
            .navigationTitle("Games")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}


enum SelectedDate: String, CaseIterable {
    case yesterday = "Yesterday"
    case today = "Today"
    case tomorrow = "Tomorrow"
}
