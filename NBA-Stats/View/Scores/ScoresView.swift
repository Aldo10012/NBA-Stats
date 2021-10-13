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
                        case .yesturday:
                            ForEach(viewModel.yesturdaysGames) { game in
                                ScoresCardView(game: game)
                            }
                        case .today:
                            ForEach(viewModel.todaysGames) { game in
                                ScoresCardView(game: game)
                            }
                        case .tomorrow:
                            ForEach(viewModel.tomorrowsGames) { game in
                                ScoresCardView(game: game)
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
    case yesturday = "Yesturday"
    case today = "Today"
    case tomorrow = "Tomorrow"
}
