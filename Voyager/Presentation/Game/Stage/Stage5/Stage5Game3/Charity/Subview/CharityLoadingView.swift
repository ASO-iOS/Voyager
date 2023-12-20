//
//  CharityLoadingView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import SwiftUI

struct CharityLoadingView: View {
    @EnvironmentObject var charityViewModel: CharityViewModel
    var body: some View {
        VStack {
            Spacer()
            Text(charityViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 64)
            
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        .onAppear {
            Task {
                try await writeTextBySymbols()
            }
        }
    }
    
    func writeTextBySymbols() async throws {
        let text = charityViewModel.isWin ? charityViewModel.currentCharity.profitDescription.description : charityViewModel.currentCharity.failureDescription.description
        for char in text {
            charityViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        BalanceManager.shared.changeBalance(by: charityViewModel.amount, gameResult: charityViewModel.isWin ? .win : .lose)
        charityViewModel.setResult()
    }
}
