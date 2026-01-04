//
//  ContentView.swift
//  DungeonDice
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var resultMessage = ""
    
    enum Dice: Int, CaseIterable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(height: 150)
            
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))]) {
                ForEach(Dice.allCases, id: \.self) { die in
                    Button("\(die.rawValue)-sided") {
                        resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice"
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
