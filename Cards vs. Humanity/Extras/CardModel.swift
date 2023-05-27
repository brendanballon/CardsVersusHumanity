//
//  CardModel.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/5/23.
//

import Foundation

protocol Card: Encodable {
    var text: String { get }
    //var pack: String { get } ** marked unused by periphery (??)
}

struct Cards: Codable {
    let black: [BlackCard]
    let white: [WhiteCard]
}

struct BlackCard: Codable, Hashable, Card  {
    let text, pack: String
    let pick: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}

struct WhiteCard: Codable, Hashable, Card {
    let text, pack: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
