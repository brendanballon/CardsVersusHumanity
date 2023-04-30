//
//  GetSize.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            }
    }
}

extension View {
    func size(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
