//
//  CardView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct CardView: View {
    
    @State var backDegree = 0.0
    @State var frontDegree = -90.0

    let card: Card
    @State var flippedOver: Bool
    let durationAndDelay : CGFloat = 0.2
    
    func flipCard () {
        flippedOver = !flippedOver
        if flippedOver {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                FrontView(card: card, degree: $frontDegree)
                    .zIndex(flippedOver ? 0 : 1)
                BackView(card: card, degree: $backDegree)
                    .zIndex(flippedOver ? 1 : 0)
            }
        }
        .onChange(of: flippedOver) { value in
            flipCard()
        }
        .onTapGesture {
            //flipCard()
        }
        .onAppear {
            if !flippedOver {
                backDegree = 0.0
                frontDegree = -90.0
            } else {
                backDegree = -90
                frontDegree = 0.0
            }
        }
    }
    
    private struct FrontView: View {
        let card: Card
        @State var textSize: CGSize = .zero
        @Binding var degree: Double
        
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
                .foregroundColor(((card as? BlackCard) != nil) ? .white : .black)
                .padding(geometry.size.width / 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(((card as? BlackCard) != nil) ? .black : .white)
                .clipShape(RoundedRectangle(cornerRadius: geometry.size.height / 20))
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.height / 20)
                        .stroke(((card as? BlackCard) != nil) ? .white : .black, lineWidth: geometry.size.width / 70)
                )
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0), perspective: 0.5)
            }
            .aspectRatio(5 / 7, contentMode: .fit)
        }
    }
    
    private struct BackView: View {
        let card: Card
        @Binding var degree: Double
        
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    Text("Cards \nvs. \nHumanity")
                        .font(.system(size: geometry.size.width))
                        .minimumScaleFactor(0.00001)
                        .fontWeight(.bold)
                    
                    Spacer()
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
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0), perspective: 0.5)
            }
            .aspectRatio(5 / 7, contentMode: .fit)
        }
    }
    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(alignment: .leading, spacing: 0) {
//                if !(faceDown ?? false) {
//                    Text(card.text.replacingOccurrences(of: "_", with: "______"))
//                        .font(.system(size: geometry.size.width / 12))
//                        .fontWeight(.semibold)
//                        .allowsTightening(true)
//
//                    Spacer()
//
//
//
//                    HStack {
//                        LogoShape()
//                            .aspectRatio(1, contentMode: .fit)
//                            .frame(maxHeight: geometry.size.height / 18)
//
//                        Text("Cards vs. Humanity")
//                            .font(.system(size: geometry.size.width / 22))
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//
//                        Spacer()
//
//                        if let blackCard = card as? BlackCard {
//                            if blackCard.pick > 1 {
//                                Text("Pick")
//                                    .textCase(.uppercase)
//                                    .font(.system(size: geometry.size.width / 18))
//                                    .fontWeight(.semibold)
//                                    .size(in: $textSize)
//                                Image(systemName: "\(String(blackCard.pick)).circle.fill")
//                                    .resizable()
//                                    .frame(maxWidth: textSize.height, maxHeight: textSize.height)
//                            }
//                        }
//                    }
//                } else {
//                    VStack {
//                        Text("Cards \nvs. \nHumanity")
//                            .font(.system(size: geometry.size.width))
//                            .minimumScaleFactor(0.00001)
//                            .fontWeight(.bold)
//
//                        Spacer()
//                    }
//                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
//                }
//            }
//            .foregroundColor(((card as? BlackCard) != nil) ? .white : .black)
//            .padding(geometry.size.width / 15)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(((card as? BlackCard) != nil) ? .black : .white)
//            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height / 20))
//            .overlay(
//                RoundedRectangle(cornerRadius: geometry.size.height / 20)
//                    .stroke(((card as? BlackCard) != nil) ? .white : .black, lineWidth: geometry.size.width / 70)
//            )
//        }
//        .aspectRatio(5 / 7, contentMode: .fit)
//    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CardView(card: BlackCard(text: "Test", pack: "dsf", pick: 2), flippedOver: false)
            CardView(card: WhiteCard(text: "Test", pack: "dsf"), flippedOver: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
