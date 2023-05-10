//
//  ContentView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    @State var code: String = "" //uutrM19
//    @State var cards: Cards?
    @State var showAlert: Bool = false
    @State var txtSize: CGSize = .zero
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Cards\nvs.\nHumanity")
                    .font(.system(size: txtSize.height * 1.75, weight: .semibold))
            }
            ScatterView(count: 5)
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
                        message: Text("Make sure the code is typed exactly as it is seen on the back of the box.")
                    )
                }
        }
        .preferredColorScheme(.light)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
