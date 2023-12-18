//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount :Int = 2
    let emojis:Array<String> = ["👀","🫁","🫀","🧠","👂🏻","🦶","🦿","👀","🫁","🫀","🧠","👂🏻","🦶","🦿"]

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            HStack {
                cardRemover
                Spacer()
                cardAdder
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns:[GridItem(),GridItem(),GridItem()]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(isFaceUp: true, content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "pencil.tip.crop.circle.badge.minus")
            .imageScale(.large)
    }

    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "pencil.tip.crop.circle.badge.plus")
            .imageScale(.large)
    }
}
    
struct CardView: View {
    @State var isFaceUp = false
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.yellow)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill(.green).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
    

#Preview {
    ContentView()
}
