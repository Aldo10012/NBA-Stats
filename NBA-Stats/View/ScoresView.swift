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
                
                Text("Scores View!")
                    .padding()
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
