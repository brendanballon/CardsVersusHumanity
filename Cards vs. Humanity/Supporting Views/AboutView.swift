//
//  AboutView.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 5/7/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("App icon")
                } footer: {
                    Text("Product authenticity verified on 5/12/23.")
                }
            }
            .navigationTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
