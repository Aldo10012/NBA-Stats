//
//  StandingsCellView.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import SwiftUI

struct StandingsCellView: View {
    
    @State var standing: Standing
    
    var body: some View {
        HStack {
            Image(standing.key)
                .resizable()
                .frame(width: 40, height: 40)
//                .background(Color(UIColor.lightGray))
                .padding(.leading)
                
            Text("\(standing.city) \(standing.name)")
                .padding()
            Spacer()
            Text("\(standing.wins) - \(standing.losses)")
                .padding()
        }
        .frame(height: 60)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(UIColor.lightGray), radius: 8, x: 4, y: 4)
        .padding(.horizontal)
        .onAppear {
            print(standing)
        }
    }
}

struct StandingsCellView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsCellView(standing: sampleStanding)
    }
}

let sampleStanding = Standing(key: "NY", city: "New York", name: "Knicks", wins: 20, losses: 25, conference: "Eastern")
