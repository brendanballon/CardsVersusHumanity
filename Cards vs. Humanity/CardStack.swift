//
//  CardStack.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct CardStack: View {
    @State var parentSize: CGSize = .zero
    @State var cardSize: CGSize = .zero
    
    @State var cards: [Card]

    @State var spread: Bool

    var body: some View {
        VStack {
            VStack {
                HStack {
                    let space = getSpacing()
                    HStack(spacing: spread ? space : (-1 * cardSize.width)) {
                        ForEach(0..<cards.count, id: \.self) { card in
                            //CardView(phrase: "Test", isFlipped: false, isBlackCard: false)
                            CardView(card: cards[card])
                                .background (
                                    GeometryReader { geometry in
                                        Color.clear
                                            .onAppear {
                                                cardSize = geometry.size
                                            }
                                    }
                                )
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: spread)
                    .fixedSize(horizontal: true, vertical: false)



                    .animation(.easeInOut(duration: 0.3), value: spread)
                    .fixedSize(horizontal: true, vertical: false)
                    
                    Spacer(minLength: 0)
                }
                .background (
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: cardSize) { value in
                                parentSize = geometry.size
                            }
                    }
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension CardStack {
    func getSpacing() -> Double {
        
        // Calculate the total width of all the rectangles
        let totalWidth = cardSize.width * CGFloat(cards.count)

        // Calculate the total distance available for the edge distances
        let totalEdgeDistance = parentSize.width - totalWidth

        // Calculate the edge distance between adjacent rectangles
        let edgeDistance = totalEdgeDistance / CGFloat(cards.count - 1)
        
        return edgeDistance
    }
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                CardStack(cards: [ BlackCard(text: "Beep", pack: "", pick: 2),
                                   BlackCard(text: "Beep", pack: "", pick: 2),
                                   BlackCard(text: "Beep", pack: "", pick: 2)
                                 ], spread: true)
                .frame(width: 400, height: 200)
            }
            //Spacer()
        }
        .previewLayout(.sizeThatFits)
    }
}
