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
    
    var body: some View {
        
        VStack {
            titleView
            Spacer()
            resultMessageView
            Spacer()
            ButtonLayout(resultMessage: $resultMessage, animationTrigger: $animationTrigger)
        }
        .padding()
    }
}


extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundStyle(.red)
    }
    
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0))
            .frame(height: 150)
            .onChange(of: animationTrigger) {
                isDoneAnimating = false
                withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                    isDoneAnimating = true
                }
            }
    }
}



#Preview {
    ContentView()
}




