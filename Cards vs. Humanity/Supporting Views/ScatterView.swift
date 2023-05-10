//
//  ScatterView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/8/23.
//

import SwiftUI

struct ScatterView: View {
    @State var count: Int
    @State var viewSize: CGSize = .zero
    
    @State private var randomBlackCard: BlackCard?
    @State private var randomWhiteCards: [WhiteCard] = []

    @State private var rotation: Double = .random(in: 345..<375)
    @State private var scale = 5.0
    @State private var done: Bool = false
    @State private var show: Bool = false
    @State private var flipped: Bool = false
    @State private var selected: Int? = nil

    @StateObject private var cardViewModel = CardViewModel()
    
    var body: some View {
        ZStack {
            ForEach(Array(randomWhiteCards.enumerated()), id:\.1) { index, element in
                let rot: Double = 345
                
                CardView(card: element, flippedOver: selected != index)
                    .opacity(show ? 1 : 0)
                    .frame(width: viewSize.width / 4)
                    .rotationEffect(.degrees(done ? rot : rotation))
                    .offset(done ? angleOf(index) : .zero)
                    .zIndex(flipped && index != selected ? 0 : 1)
                    .animation(.spring(), value: done)
                    .onTapGesture {
                        selected = index
                        print("dd")
                    }
            }
            
            CardView(card: randomBlackCard ?? BlackCard(text: "", pack: "", pick: 0), flippedOver: true)
                .frame(width: viewSize.width / 4)
                .scaleEffect(scale)
                .animation(.spring(response: 0.17, dampingFraction: 0.51, blendDuration: 1.99), value: scale)
                .rotationEffect(.degrees(rotation))
        }
        .onAppear {
            scale = 1
            
            cardViewModel.fetchCards { result in
                switch result {
                case .success(let fetchedCards):
                    DispatchQueue.main.async {
                        cardViewModel.cards = fetchedCards
                        
                        let (blackCard, whiteCards) = cardViewModel.randomize(whiteCardsCount: count)
                        randomBlackCard = blackCard
                        randomWhiteCards = whiteCards
                    }
                case .failure(let error):
                    print("Error fetching cards: \(error)")
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring(response: 0.17, dampingFraction: 0.51, blendDuration: 1.99)) {
                    done = true
                }
                withAnimation(.none) {
                    show = true
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .size(in: $viewSize)
    }
}

extension ScatterView {
    func angleOf(_ index: Int) -> CGSize {
        var size: CGSize = .zero
        let increment = (2 * CGFloat.pi) / CGFloat(count)
        
        size.width = cos(CGFloat(index) * increment) * (viewSize.width / 3)
        size.height = sin(CGFloat(index) * increment) * (viewSize.width / 4)
        
        return size
    }
    
//    func select(_ index: Double) {
//        flipped = !flipped
//        if flipped {
//            with
//        }
//    }
}

struct ScatterView_Previews: PreviewProvider {
    static var previews: some View {
        ScatterView(count: 5)
    }
}
