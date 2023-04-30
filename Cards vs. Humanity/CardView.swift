//
//  CardView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let faceDown: Bool?
    
    @State var textSize: CGSize = .zero
    
    init(card: Card, faceDown: Bool? = false) {
        self.card = card
        self.faceDown = faceDown
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                if !(faceDown ?? false) {
                    Text(card.text.replacingOccurrences(of: "_", with: "______"))
                        .font(.system(size: geometry.size.width / 12))
                        .fontWeight(.semibold)
                        .allowsTightening(true)
                    
                    Spacer()
                    
                    
                    
                    HStack {
                        LogoShape()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxHeight: geometry.size.height / 18)
                        
                        Text("Cards vs. Humanity")
                            .font(.system(size: geometry.size.width / 22))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        if let blackCard = card as? BlackCard {
                            if blackCard.pick > 1 {
                                Text("Pick")
                                    .textCase(.uppercase)
                                    .font(.system(size: geometry.size.width / 18))
                                    .fontWeight(.semibold)
                                    .size(in: $textSize)
                                Image(systemName: "\(String(blackCard.pick)).circle.fill")
                                    .resizable()
                                    .frame(maxWidth: textSize.height, maxHeight: textSize.height)
                            }
                        }
                    }
                } else {
                    Text("Cards \nvs. \nHumanity")
                        .font(.system(size: geometry.size.width))
                        .minimumScaleFactor(0.00001)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
            }
            .foregroundColor(((card as? BlackCard) != nil) ? .white : .black)
            .padding(geometry.size.width / 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(((card as? BlackCard) != nil) ? .black : .white)
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height / 20))
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.height / 20)
                    .stroke(((card as? BlackCard) != nil) ? .white : .black, lineWidth: geometry.size.width / 70)
            )
        }
        .aspectRatio(5 / 7, contentMode: .fit)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CardView(card: BlackCard(text: "Test", pack: "dsf", pick: 3))
            CardView(card: WhiteCard(text: "Test", pack: "dsf"))
        }
            .previewLayout(.sizeThatFits)
    }
}
