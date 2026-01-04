//
//  ButtonLayout.swift
//  DungeonDice
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ButtonLayout: View {
    
    enum Dice: Int, CaseIterable, Identifiable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, fifty = 50, hundred = 100
        
        var id: Int { rawValue }
        var description: String { "\(rawValue)-sided" }
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
    }
    
    @State private var buttonsLeftOver = 0
    
    @Binding var resultMessage: String
    @Binding var animationTrigger: Bool
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0
    let buttonWidth: CGFloat = 102
    
    var body: some View {
            VStack {
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
//            .onChange(of: deviceWidth) {
//                arrangeGridItems(deviceWidth: deviceWidth)
//            }
//            .onAppear {
//                arrangeGridItems(deviceWidth: deviceWidth)
//            }
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
                }
            }
            .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
                arrangeGridItems(deviceWidth: deviceWidth)
            }

    }
    
    func arrangeGridItems(deviceWidth: CGFloat) {
        var screenWidth = deviceWidth - horizontalPadding * 2 // default padding
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        // calculate number of buttons per row
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
    }
}

#Preview {
    ButtonLayout(resultMessage: .constant(""), animationTrigger: .constant(false))
}
