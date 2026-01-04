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
    @State private var animationTrigger = false
    @State private var isDoneAnimating = true
    
    @State private var buttonsLeftOver = 0
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0
    let buttonWidth: CGFloat = 102
    
    enum Dice: Int, CaseIterable, Identifiable {
        
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundred = 100
        
        var id: Int {
            rawValue
        }
        
        var description: String {
            "\(rawValue)-sided"
        }
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
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
                //                .scaleEffect(isDoneAnimating ? 1.0 : 0.6)
                //                .opacity(isDoneAnimating ? 1.0 : 0.2)
                    .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                    .frame(height: 150)
                    .onChange(of: animationTrigger) {
                        isDoneAnimating = false
                        withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                            isDoneAnimating = true
                        }
                    }
                
                Spacer()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver)) { die in
                        Button(die.description) {
                            resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice"
                            animationTrigger.toggle()
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                // to position buttons centrally on last row if needed
                HStack {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver)) { die in
                        Button(die.description) {
                            resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice"
                            animationTrigger.toggle()
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
            }
            .padding()
            .onChange(of: geo.size.width) {
                arrangeGridItems(geo: geo)
            }
            .onAppear {
                arrangeGridItems(geo: geo)
            }
        }
        
    }
    
    func arrangeGridItems(geo: GeometryProxy) {
        var screenWidth = geo.size.width - horizontalPadding * 2 // default padding
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        // calculate number of buttons per row
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
//        print("numberOfButtonsPerRow: \(numberOfButtonsPerRow)")
//        print("buttonsLeftOver = \(buttonsLeftOver)")

    }
    
}

#Preview {
    ContentView()
}
