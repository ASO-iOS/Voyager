//
//  WheelComplicatedResultStateView.swift
//  Voyager
//
//  Created by admin on 13.12.2023.
//

import SwiftUI

struct WheelComplicatedResultStateView: View {
    @EnvironmentObject var wheelViewModel: WheelComplicatedViewModel
    var completion: () -> Void = {}
    var body: some View {
        VStack {
            Text("\(wheelViewModel.resultGameRWCData.num), \(wheelViewModel.resultGameRWCData.color.colorName)")
                .gameButtonStyle(.textBack)
                .padding(.bottom)
            Text(resultVisual())
                .gameButtonStyle(.textBack)
                .padding(.bottom, 64)
            Button(action: {
                wheelViewModel.resetGame()
            }, label: {
                Text("Еще разок?")
                    .gameButtonStyle(.nextButton)
            })
            Button(action: {
                completion()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
            })
            .padding(.bottom, 45)
            
        }
        .onAppear {
            BalanceManager.shared.changeBalance(by: wheelViewModel.resultAmount.bet, gameResult: wheelViewModel.resultAmount.result)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .miniGameBackground()
    }
    
    private func resultVisual() -> String {
        return "\(wheelViewModel.resultAmount.result == .win ? "+" : "-")\(wheelViewModel.resultAmount.bet)"
    }
}
