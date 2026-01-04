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
            
            Group {
                HStack {
                    Button("\(Dice.four.rawValue)-side") {
                        resultMessage = "You rolled a \(Dice.four.roll()) on a \(Dice.four.rawValue)-sided dice"
                    }
                    Spacer()
                    Button("\(Dice.six.rawValue)-side") {
                        resultMessage = "You rolled a \(Dice.six.roll()) on a \(Dice.six.rawValue)-sided dice"
                    }
                    Spacer()
                    Button("\(Dice.eight.rawValue)-side") {
                        resultMessage = "You rolled a \(Dice.eight.roll()) on a \(Dice.eight.rawValue)-sided dice"
                    }
                }
                
                HStack {
                    Button("\(Dice.ten.rawValue)-side") {
                        resultMessage = "You rolled a \(Dice.ten.roll()) on a \(Dice.ten.rawValue)-sided dice"
                    }
                    Spacer()
                    Button("\(Dice.twelve.rawValue)-side") {
                        resultMessage = "You rolled a \(Dice.twelve.roll()) on a \(Dice.twelve.rawValue)-sided dice"
                    }
                    Spacer()
                    Button("\(Dice.twenty.rawValue)-side") {
                        resultMessage = "You rolled a \(Dice.twenty.roll()) on a \(Dice.twenty.rawValue)-sided dice"
                    }
                }
                
                Button("\(Dice.hundred.rawValue)-side") {
                    resultMessage = "You rolled a \(Dice.hundred.roll()) on a \(Dice.hundred.rawValue)-sided dice"
                }
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
