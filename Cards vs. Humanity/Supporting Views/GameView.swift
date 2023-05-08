//
//  GameView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct GameView: View {
    @State var cards: Cards?
    @State var randomCard: BlackCard?
    
    @State var allowReordering: Bool = true
    @State var viewSize: CGSize = .zero
    
    init(cards: Cards? = nil, randomCard: BlackCard? = nil) {
        self.cards = cards
        self.randomCard = randomCard
    }
    
    var body: some View {
        
        VStack {
            CardView(card: randomCard ?? BlackCard(text: "", pack: "", pick: 0))
                .frame(width: 250)
                .onTapGesture {
                    randomize()
                }
                .frame(width: 100)
            
            Spacer()
            
            
            CardStack(cards: [ WhiteCard(text: "Te", pack: ""),
                               WhiteCard(text: "gg", pack: ""),
                               WhiteCard(text: "yyyye", pack: ""),
                               WhiteCard(text: "ge", pack: ""),
                               WhiteCard(text: "Tyouyoe", pack: "")
            
                            ], allowReordering: allowReordering)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if let savedCardsData = UserDefaults.standard.data(forKey: "cardsData"),
               let savedCards = try? JSONDecoder().decode(Cards.self, from: savedCardsData) {
                self.cards = savedCards
            } else {
                fetchCards()
            }
            
            randomize()
        }
    }
}

extension GameView {
    func randomize() {
        if let cards = cards {
            if !cards.black.isEmpty {
                if let randomIndex = (0..<cards.black.count).randomElement() {
                    self.randomCard = cards.black[randomIndex]
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
