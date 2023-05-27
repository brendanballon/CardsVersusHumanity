//
//  CardStack.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/5/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct CardStack: View {
    @State var cards: [WhiteCard]
    @State var allowReordering: Bool
    
    @State var draggedCard: WhiteCard?
    @State var isDragging: Bool = false
    
    @State var cardSize: CGSize = .zero
    @State var parentSize: CGSize = .zero

    @Binding var selected: WhiteCard?

    var namespace: Namespace.ID

    var body: some View {
        let gridItems = Array(repeating: GridItem(.flexible(), spacing: parentSize.width / CGFloat((-cards.count + 1))), count: cards.count)
        
        LazyVGrid(columns: gridItems) {
            ForEach(Array(cards.enumerated()), id:\.1) { index, element in
                if element != selected {
                    CardView(card: element) { card in
                        if element == cards.last {
                            withAnimation(.spring()) {
                                selected = element
                            }
                        } else if selected != nil {
                            withAnimation() {
                                selected = nil
                            }
                            //cards.move(fromOffsets: IndexSet(integer: index), toOffset: cards.count)
                        } else {
                            cards.move(fromOffsets: IndexSet(integer: index), toOffset: cards.count)
                        }
                    }
                    .matchedGeometryEffect(id: "ge\(index)", in: namespace)
                    .animation(.default, value: cards)
                    .contentShape(.dragPreview, CardShape())
                    .onDrag {
                        self.draggedCard = element
                        return NSItemProvider(contentsOf: URL(string: "\(element.text)"))!
                    }
                    .onDrop(of: ["card"], delegate: CardDropDelegate(card: element, cards: $cards, draggedCard: $draggedCard, isDragging: $isDragging))
                    .size(in: $cardSize)
                }
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
//
//struct CardStack_Previews: PreviewProvider {
//    static var previews: some View {
//        CardStack(cards: [WhiteCard(text: "1", pack: ""),
//                          WhiteCard(text: "1", pack: ""),
//                          WhiteCard(text: "1", pack: ""),
//                          WhiteCard(text: "1", pack: ""),
//                          WhiteCard(text: "1", pack: "")],
//                  allowReordering: true,
//                  selected: <#T##Binding<WhiteCard?>#>,
//                  namespace: <#T##Namespace.ID#>)
//    }
//}
