//
//  CharityResultView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import SwiftUI

struct CharityResultView: View {
    @EnvironmentObject var charityViewModel: CharityViewModel
    var completion: () -> Void
    var body: some View {
        VStack {
            Spacer()
            Text("\(charityViewModel.isWin ? "+" : "-")\(charityViewModel.amount)")
            Text(charityViewModel.textOutput)
                .gameTextStyle(.textBack)
            VStack {
                Button(action: {
                    charityViewModel.resetGame()
                }, label: {
                    Text("Еще раз?")
                        .gameButtonStyle(.nextButton)
                })
                Button(action: {
                    completion()
                }, label: {
                    Text("Дальше")
                        .gameButtonStyle(.nextButton)
                })
            }
            .disabled(!charityViewModel.gameFinished)
            .opacity(charityViewModel.gameFinished ? 1.0 : 0.3)
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
        let text = charityViewModel.isWin ? charityViewModel.currentCharity.profitDescription.resultText : charityViewModel.currentCharity.failureDescription.resultText
        for char in text {
            charityViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        charityViewModel.gameFinished.toggle()
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//        charityViewModel.setResult()
    }
}
