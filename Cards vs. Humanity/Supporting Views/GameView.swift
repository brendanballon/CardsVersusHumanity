//
//  GameView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct GameView: View {
    @State private var randomBlackCard: BlackCard?
    @State private var randomWhiteCards: [WhiteCard] = []
    
    @StateObject private var cardViewModel = CardViewModel()
    @State var allowReordering: Bool = true
    @State var viewSize: CGSize = .zero
    
//    init(cards: Cards? = nil, randomCard: BlackCard? = nil) {
//        self.cards = cards
//        self.randomCard = randomCard
//    }
    
    var body: some View {
        
        VStack {
            CardView(card: randomBlackCard ?? BlackCard(text: "", pack: "", pick: 0), flippedOver: false)
                .frame(width: 250)
                .onTapGesture {
                    let (blackCard, whiteCards) = cardViewModel.randomize(whiteCardsCount: 5)
                    randomBlackCard = blackCard
                    randomWhiteCards = whiteCards
                }
                .frame(width: 100)
            
            Spacer()
            
            
            CardStack(cards: randomWhiteCards, allowReordering: allowReordering)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            cardViewModel.fetchCards { result in
                switch result {
                case .success(let fetchedCards):
                    DispatchQueue.main.async {
                        cardViewModel.cards = fetchedCards
                        
                        let (blackCard, whiteCards) = cardViewModel.randomize(whiteCardsCount: 5)
                        randomBlackCard = blackCard
                        randomWhiteCards = whiteCards
                    }
                case .failure(let error):
                    print("Error fetching cards: \(error)")
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
