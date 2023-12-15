//
//  BalanceView.swift
//  Voyager
//
//  Created by admin on 14.12.2023.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject var displayCash = BalanceManager.shared
    var body: some View {
        HStack {
            Image("coin_balance")
                .resizable()
                .frame(width: 30, height: 30)
            Text("\(displayCash.balance)")
                .foregroundStyle(.white)
                .font(.system(size: 18).monospaced().bold())
                .padding(.trailing)
        }
    }
}
