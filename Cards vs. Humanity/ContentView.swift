//
//  ContentView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @State var code: String = "" //uutrM19
    @State var cards: Cards?
    @State var showAlert: Bool = false
    @State var randomCard: String = ""
    @State var txtSize: CGSize = .zero
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Cards\nvs.\nHumanity")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Spacer()
            Text("Verify ownership")
                .font(.title)
                .size(in: $txtSize)
            
            TextField("", text: $code)
                .submitLabel(.done)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    authenticate(code: code) { success in
                        if success {
                            print("success")
                            code = ""
                        } else {
                            print("failed to verify authenticity")
                            code = ""
                            showAlert = true
                        }
                    }
                }
                .frame(maxWidth: txtSize.width * 1.2)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Product Authenticity Verification Failed"),
                        message: Text("Make sure the code is typed exactly how it is seen on the back of the box.")
                    )
                }
        }
        .padding()
        .onAppear {
            // Read cards from UserDefaults
            if let savedCardsData = UserDefaults.standard.data(forKey: "cardsData"),
               let savedCards = try? JSONDecoder().decode(Cards.self, from: savedCardsData) {
                self.cards = savedCards
            } else {
                // Fetch cards
                fetchCards()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
