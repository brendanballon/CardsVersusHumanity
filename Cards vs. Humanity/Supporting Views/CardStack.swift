//
//  CardStack.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/5/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct CardStack: View {
    
    @State var cards: [Card]
    @State var allowReordering: Bool
    
    @State var draggedCard: Card?
    @State var isDragging: Bool = false
    @State private var dragOffset: CGSize = .zero
    @State private var spacing: CGFloat = 0
    
    @State var cardSize: CGSize = .zero
    @State var parentSize: CGSize = .zero
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.flexible(), spacing: parentSize.width / CGFloat((-cards.count + 1))), count: cards.count)
        
        LazyVGrid(columns: gridItems) {
            ForEach(cards, id:\.text) { card in
                if allowReordering {
                    CardView(card: card)
                        .contentShape(.dragPreview, CardShape())
                        .onDrag {
                            self.draggedCard = card
                            return NSItemProvider(contentsOf: URL(string: "\(card.text)"))!
                        }
                        .onDrop(of: ["card"], delegate: CardDropDelegate(card: card, cards: $cards, draggedCard: $draggedCard, isDragging: $isDragging))
                        .size(in: $cardSize)
                } else {
                    CardView(card: card)
                }
            }
        }
        .size(in: $parentSize)
    }
}

struct CardDropDelegate : DropDelegate {
    let card: Card
    @Binding var cards: [Card]
    @Binding var draggedCard : (Card)?
    @Binding var isDragging: Bool
    
    func performDrop(info: DropInfo) -> Bool {
        self.draggedCard = nil
        return true
    }
    
    func dropExited(info: DropInfo) {
        self.isDragging = false
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedCard = self.draggedCard else {
            return
        }
        
        if draggedCard.text != card.text {
            if let from = cards.firstIndex(where: { $0.text == draggedCard.text }),
               let to = cards.firstIndex(where: { $0.text == card.text }) {
                withAnimation(.default) {
                    cards.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardStack(cards: [
                WhiteCard(text: "Card 1", pack: "Pack 1"),
                WhiteCard(text: "Card 2", pack: "Pack 1"),
                WhiteCard(text: "Card 3", pack: "Pack 1"),
                WhiteCard(text: "Card 4", pack: "Pack 1"),
                WhiteCard(text: "Card 5", pack: "Pack 2")
            ], allowReordering: true)
        }
    }
}
