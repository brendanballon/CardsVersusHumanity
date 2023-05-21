//
//  CardView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @Binding var faceDown: Bool
    
    @State var tappable: Bool?
    
    let onTap: ((Card?) -> Void)?

    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    @State private var scale = 1.0
    private let durationAndDelay: CGFloat = 0.1
    
    init(card: Card, faceDown: Binding<Bool>? = nil, tappable: Bool? = true, onTap: ((Card?) -> Void)? = nil) {
        self.card = card
        self._faceDown = faceDown ?? .constant(false)
        self._tappable = State(initialValue: tappable)
        self.onTap = onTap
    }
    
    var body: some View {
        VStack {
            ZStack {
                FrontView(card: card)
                    .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0), perspective: 0.25)
                    .scaleEffect(scale)
                BackView(card: card)
                    .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0), perspective: 0.25)
                    .scaleEffect(scale)
            }
            .onTapGesture {
                if tappable ?? true {
                    faceDown.toggle()
                }
                if let onTap = onTap {
                    onTap(card)
                }
            }
        }
        .onChange(of: faceDown) { _ in
            if !faceDown {
                withAnimation(.linear(duration: durationAndDelay)) {
                    scale = 1.25
                    backDegree = 90
                }
                withAnimation(.easeOut(duration: durationAndDelay).delay(durationAndDelay)){
                    frontDegree = 0
                    scale = 1
                }
            } else {
                withAnimation(.linear(duration: durationAndDelay)) {
                    frontDegree = -90
                    scale = 1.25
                }
                withAnimation(.easeOut(duration: durationAndDelay).delay(durationAndDelay)){
                    backDegree = 0
                    scale = 1
                }
            }
        }
        .onAppear {
            withAnimation(.none) {
                if faceDown != false {
                    backDegree = 0.0
                    frontDegree = -90
                } else {
                    backDegree = 90
                    frontDegree = 0
                }
            }
        }
    }
}

//MARK: Front view
extension CardView {
    private struct FrontView: View {
        let card: Card
        
        @State private var textSize: CGSize = .zero

        var body: some View {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    Text(card.text.replacingOccurrences(of: "_", with: "_______"))
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
                }
                .foregroundColor(card is BlackCard ? .white : .black)
                .padding(geometry.size.width / 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: geometry.size.height / 20)
                        .stroke(card is BlackCard ? .white : .black, lineWidth: geometry.size.width / 70)
                        .background {
                            RoundedRectangle(cornerRadius: geometry.size.height / 20)
                                .fill(card is BlackCard ? .black : .white)
                        }
                }
            }
            .aspectRatio(5 / 7, contentMode: .fit)
        }
    }
}

//MARK: Back view
extension CardView {
    private struct BackView: View {
        let card: Card
        
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    Text("Cards \nvs. \nHumanity")
                        .font(.system(size: geometry.size.width))
                        .minimumScaleFactor(0.001)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .foregroundColor(card is BlackCard ? .white : .black)
                .padding(geometry.size.width / 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: geometry.size.height / 20)
                        .stroke(card is BlackCard ? .white : .black, lineWidth: geometry.size.width / 70)
                        .background {
                            RoundedRectangle(cornerRadius: geometry.size.height / 20)
                                .fill(card is BlackCard ? .black : .white)
                        }
                }
            }
            .aspectRatio(5 / 7, contentMode: .fit)
        }
    }
}

struct CardViewTest: View {
    @State var test = true
    
    var body: some View {
        VStack {
            CardView(card: WhiteCard(text: "", pack: ""), faceDown: $test)
            CardView(card: WhiteCard(text: "", pack: ""), faceDown: .constant(false))
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
//            CardView(card: BlackCard(text: "Test", pack: "dsf", pick: 2), faceDown: test)
//            CardView(card: WhiteCard(text: "Test", pack: "dsf"), faceDown: .constant(true))
            CardViewTest()
        }
        .previewLayout(.sizeThatFits)
    }
}
