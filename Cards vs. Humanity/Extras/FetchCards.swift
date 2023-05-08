//
//  FetchCards.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import Foundation

func fetchCards() {
    let defaults = UserDefaults.standard
    
    if let savedCardsData = defaults.object(forKey: "cardsData") as? Data,
       let savedCards = try? JSONDecoder().decode(Cards.self, from: savedCardsData) {
        // Use the saved data
        print(savedCards)
    } else {
        let task = URLSession.shared.dataTask(with: URL(string: String("https://restagainsthumanity.com/api/v2/cards?"))!) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(String(data: data, encoding: .utf8)!)
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(Cards.self, from: data)
                    
                    // Store the decoded data in UserDefaults
                    let encodedData = try JSONEncoder().encode(decodedData)
                    defaults.set(encodedData, forKey: "cardsData")
                    
                    print(decodedData)
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
        
        task.resume()
    }
}
