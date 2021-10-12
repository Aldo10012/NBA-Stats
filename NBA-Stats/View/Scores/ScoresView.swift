//
//  ContentView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct ScoresView: View {
    
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
                
                Text(selectedDate.rawValue)
                
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.games) { game in
                            ScoresCardView(game: game)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Games")
        }
    }
    
    func updateView() {
        switch selectedDate {
        case .yesturday:
            viewModel.getGamesByDate(yesterday) { result in
                switch result {
                case let .success(games):
                    self.viewModel.games = games
                case let .failure(error):
                    print(error)
                }
            }
            
        case .today:
            viewModel.getGamesByDate(today) { result in
                switch result {
                case let .success(games):
                    self.viewModel.games = games
                case let .failure(error):
                    print(error)
                }
            }
            
        case .tomorrow:
            viewModel.getGamesByDate(tomorrow) { result in
                switch result {
                case let .success(games):
                    self.viewModel.games = games
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}


enum SelectedDate: String, CaseIterable {
    case yesturday = "Yesturday"
    case today = "Today"
    case tomorrow = "Tomorrow"
}
