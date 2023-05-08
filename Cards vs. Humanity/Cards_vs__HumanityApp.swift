//
//  Cards_vs__HumanityApp.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

@main
struct Cards_vs__HumanityApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            CardStack(cards: [
                WhiteCard(text: "Card 1", pack: "Pack 1"),
                WhiteCard(text: "Card 2", pack: "Pack 1"),
                WhiteCard(text: "Card 3", pack: "Pack 1"),
                WhiteCard(text: "Card 4", pack: "Pack 1"),
                WhiteCard(text: "Card 5", pack: "Pack 2")
            ], allowReordering: false)
                .aspectRatio(1, contentMode: .fit)
        }
    }
}
