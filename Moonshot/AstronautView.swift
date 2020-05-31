//
//  AstronautView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 5/28/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missionsFlown = [String]()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                }
                VStack {
                    Text("Missions Flown")
                        .font(.headline)
                    ForEach(0..<self.missionsFlown.count) {
                        Text(self.missionsFlown[$0])
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let missions: [Mission] = Bundle.main.decode("missions.json")

        var matches = [String]()

        for mission in missions {
            for _ in mission.crew {
                if let match = mission.crew.first(where: {$0.name == astronaut.id}) {
                    matches.append("Apollo \(mission.id) as \(match.role)")
                    break
                }
            }
        }
        self.missionsFlown = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronaut: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaut[0])
    }
}
