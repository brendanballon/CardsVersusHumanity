//
//  CardStack.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/5/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension View {
    // Applies the given transform if the given condition evaluates to `true`.
    // - Parameters:
    //   - condition: The condition to evaluate.
    //   - transform: The transform to apply to the source `View`.
    // - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct CardStack: View {
    
    @Namespace var name
    
    @State var cards: [WhiteCard]
    @State var allowReordering: Bool
    
    @State var draggedCard: WhiteCard?
    @State var bool: Bool = true
    @State var isDragging: Bool = false
    @State private var dragOffset: CGSize = .zero
    @State private var spacing: CGFloat = 0
    
    @State var cardSize: CGSize = .zero
    @State var parentSize: CGSize = .zero
    
    let posx = UIScreen.main.bounds.size.width / 2
    let posy = UIScreen.main.bounds.size.height / 2
    
    @Binding var selected: WhiteCard?
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.flexible(), spacing: parentSize.width / CGFloat((-cards.count + 1))), count: cards.count)
        
        LazyVGrid(columns: gridItems) {
            ForEach(Array(cards.enumerated()), id:\.1) { index, element in
                CardView(card: element)
                    .contentShape(.dragPreview, CardShape())
                    .onDrag {
                        self.draggedCard = element
                        return NSItemProvider(contentsOf: URL(string: "\(element.text)"))!
                    }
                    .onDrop(of: ["card"], delegate: CardDropDelegate(card: element, cards: $cards, draggedCard: $draggedCard, isDragging: $isDragging))
                    .size(in: $cardSize)
            }
        }
        .size(in: $parentSize)
    }
}

struct CardDropDelegate: DropDelegate {
    let card: WhiteCard
    @Binding var cards: [WhiteCard]
    @Binding var draggedCard : (WhiteCard)?
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
