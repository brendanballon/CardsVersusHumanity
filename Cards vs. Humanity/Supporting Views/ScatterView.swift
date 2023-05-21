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
    @State var flippedCards: [Bool] = Array(repeating: false, count: 5)
    @State private var rotations: [Double] = []

    @State private var rotation: Double = .random(in: 345..<375)
    @State private var scale = 5.0
    @State private var done: Bool = false
    @State private var show: Bool = false
    @State private var selected: Int? = nil

    @StateObject private var cardViewModel = CardViewModel()
    
    func toggleAllExceptOne(_ array: inout [Bool], excludeIndex: Int) {
        for (index, _) in array.enumerated() {
            if index != excludeIndex {
                array[index] = !array[index]
            }
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(Array(randomWhiteCards.enumerated()), id:\.1) { index, element in
                CardView(card: element, faceDown: $flippedCards[index], tappable: false) { _ in
                    if selected == nil {
                        selected = index
                        toggleAllExceptOne(&flippedCards, excludeIndex: selected!)
                    }
                }
                .contentShape(Rectangle())
                .opacity(show ? 1 : 0)
                .zIndex(selected == index ? 1 : 0)
                .frame(width: viewSize.width / 4)
                .rotationEffect(.degrees(done ? rotations[index] : rotation))
                .offset(done ? angleOf(index) : .zero)
            }
            
            CardView(card: randomBlackCard ?? BlackCard(text: "", pack: "", pick: 0))
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
                        
                        //flippedCards = randomWhiteCards.map { _ in false }
                        rotations = randomWhiteCards.map { _ in .random(in: 345..<375) }
                        print("rots \(rotations)")
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
}

struct ScatterView_Previews: PreviewProvider {
    static var previews: some View {
        ScatterView(count: 5)
    }
}
