//
//  ShellGameViewModel.swift
//  dices
//
//  Created by mnats on 21.11.2023.
//

//MARK: - UPDATE

import SwiftUI

final class ShellGameViewModel: ObservableObject {
    @Published var cupViews: [CupView]
    @Published var isFinish: Bool
    @Published var isWin: Bool
    @Published var readyToReveal: Bool
    @Published var bet = 0
    
    var cupsCount: Int
    @Published var winChance: Float
    
    init(cupsCount: Int = 3, winChance: Float = 1) {
        self.cupViews = [CupView](repeating: CupView(id: 0), count: cupsCount)
        self.cupsCount = cupsCount
        self.winChance = winChance
        self.isFinish = false
        self.isWin = false
        self.readyToReveal = false
    }
    
    func shuffleCups() {
//        isFinish = false
        isWin = false
        cupViews.shuffle()
    }
    
    func setUpCups(reveal: Binding<Bool>) {
        cupViews = []
        for i in 0..<cupsCount {
            self.cupViews.append(
                CupView(id: i,
                        reveal: i == 0 ? reveal : .constant(false),
                        winChance: winChance) { [self] isWin in
                            self.isWin = isWin
                            self.readyToReveal = false
//                            Task {
//                                try? await Task.sleep(nanoseconds: 2_000_000_000)
                                self.isFinish = true
                            
//                            if isWin {
//                                balanceManager.changeBalance(amount: bet)
//                                
//                            } else {
//                                balanceManager.changeBalance(amount: -bet)
//                            }
//                            }
                        }
            )
        }
    }
}
