//
//  CardModel.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/5/23.
//

import Foundation

protocol Card: Encodable {
    var id: UUID { get }
    var text: String { get }
    var pack: String { get }
}

struct Cards: Codable {
    let black: [BlackCard]
    let white: [WhiteCard]
}

struct BlackCard: Identifiable, Codable, Card  {
    var id = UUID()
    let text, pack: String
    let pick: Int
}

struct WhiteCard: Identifiable, Codable, Card {
    var id = UUID()
    let text, pack: String
}
