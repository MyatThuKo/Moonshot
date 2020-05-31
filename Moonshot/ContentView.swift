//
//  ContentView.swift
//  Moonshot
//
//  Created by Myat Thu Ko on 5/28/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

struct ContentView: View {
    
    @State private var showCrews = false
    @State private var menuText = "Show Crews"
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionVIew(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if !self.showCrews {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text("Astronauts: \(self.filterAstronauts(by: mission))")
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button(self.menuText) {
                self.showCrews.toggle()
                if self.showCrews {
                    self.menuText = "Show Dates"
                } else {
                    self.menuText = "Show Crews"
                }
            })
        }
    }
    
    func filterAstronauts(by mission: Mission) -> String {
        var crewNames = ""
        for member in mission.crew {
            if (astronauts.first(where: { $0.id == member.name }) != nil) {
                crewNames += "\(member.name.capitalizingFirstLetter()), "
            } else {
                fatalError("Missing \(member)")
            }
        }
        //Removing the last "space" and "comma"
        crewNames.remove(at: crewNames.index(before: crewNames.endIndex))
        crewNames.remove(at: crewNames.index(before: crewNames.endIndex))
        
        return crewNames
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
