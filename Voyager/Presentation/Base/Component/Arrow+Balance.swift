//
//  Arrow+Balance.swift
//  Voyager
//
//  Created by admin on 20.12.2023.
//

import SwiftUI

struct ArrowBalanceView: View {
    let action: () -> Void
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    action()
                }, label: {
                    Image("backArrow")
                        .resizable()
                        .frame(width: 20, height: 30)
                        .padding()
                })
                Spacer()
                BalanceView()
            }
            Spacer()
        }
    }
}
