//
//  FetchCards.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI
import Foundation
import Combine

class CardViewModel: ObservableObject {
    @Published var cards: Cards = Cards(black: [], white: [])
    
    func fetchCards(completion: @escaping (Result<Cards, Error>) -> Void) {
        let defaults = UserDefaults.standard

        if let savedCardsData = defaults.object(forKey: "cardsData") as? Data,
           let savedCards = try? JSONDecoder().decode(Cards.self, from: savedCardsData) {
            completion(.success(savedCards))
        } else {
            let task = URLSession.shared.dataTask(with: URL(string: String("https://restagainsthumanity.com/api/v2/cards?"))!) { data, response, error in
                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(Cards.self, from: data)
                        let encodedData = try JSONEncoder().encode(decodedData)
                        
                        defaults.set(encodedData, forKey: "cardsData")
                        completion(.success(decodedData))
                    } catch {
                        print("Error decoding data: \(error)")
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    func randomize(whiteCardsCount: Int?) -> (BlackCard?, [WhiteCard]) {
        var randomBlackCard: BlackCard?
        var randomWhiteCards: [WhiteCard] = []

        if !cards.black.isEmpty {
            if let randomIndex = (0..<cards.black.count).randomElement() {
                randomBlackCard = cards.black[randomIndex]
            }
        }
        
        if let whiteCardsCount = whiteCardsCount, !cards.white.isEmpty {
            for _ in 0..<cards.white.count {
                if randomWhiteCards.count >= whiteCardsCount {
                    break
                }
                
                if let randomIndex = (0..<cards.white.count).randomElement() {
                    randomWhiteCards.append(cards.white[randomIndex])
                }
            }
        }

        return (randomBlackCard, randomWhiteCards)
    }
}

struct CardViewModelEnvironmentKey: EnvironmentKey {
    static let defaultValue: CardViewModel = CardViewModel()
}

extension EnvironmentValues {
    var cardViewModel: CardViewModel {
        get { self[CardViewModelEnvironmentKey.self] }
        set { self[CardViewModelEnvironmentKey.self] = newValue }
    }
}
