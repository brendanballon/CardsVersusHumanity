//
//  GameView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct GameView: View {
    @Environment(\.cardViewModel) private var cardViewModel
    @Namespace var animation
    
    @State private var randomBlackCard: BlackCard?
    @State private var randomWhiteCards: [WhiteCard] = []

    @State var selected: WhiteCard? = nil

    var body: some View {
        VStack {
            CardView(card: randomBlackCard ?? BlackCard(text: "", pack: "", pick: 0)) { _ in
                let (blackCard, whiteCards) = cardViewModel.randomize(whiteCardsCount: 5)
                randomBlackCard = blackCard
                randomWhiteCards = whiteCards
            }
                .frame(width: 250)
                .fixedSize()
            
            Spacer()
            
            if !randomWhiteCards.isEmpty {
                CardStack(cards: randomWhiteCards, allowReordering: true, selected: $selected, namespace: animation)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if selected != nil {
                CardView(card: selected!) { _ in
                    withAnimation(.spring()) {
                        selected = nil
                    }
                }
                .matchedGeometryEffect(id: "ge4", in: animation)
                .frame(maxWidth: 200)
            }
        }
        .onAppear {
            cardViewModel.fetchCards { result in
                switch result {
                case .success(let fetchedCards):
                    DispatchQueue.main.async {
                        cardViewModel.cards = fetchedCards

                        let (blackCard, whiteCards) = cardViewModel.randomize(whiteCardsCount: 5)
                        randomBlackCard = blackCard
                        randomWhiteCards = whiteCards
                        print(randomWhiteCards)
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
