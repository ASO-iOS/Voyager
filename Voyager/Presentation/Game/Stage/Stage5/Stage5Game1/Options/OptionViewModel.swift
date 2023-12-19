//
//  OptionViewModel.swift
//  MinigamesMZ
//
//  Created by mnats on 24.11.2023.
//

import SwiftUI

enum Direction {
    case up, down
}

@MainActor
final class OptionViewModel: ObservableObject {
    @Published var sliderValue: CGFloat = 0
    @Published var isAnimating = false
    @Published var buttonDisabled = false
    @Published var isFinishPresented = false
    @Published var gameResult: GameResult = .draw
    
    @Published var bet = 0
    
    private var winChance = 0.5
    private var karmaBonus: Double  {
        switch StorageManager.shared.gameKarma {
        case 0:
            return -0.33
            
        case 5:
            return -0.30
            
        case 10:
            return -0.27
            
        case 15:
            return -0.24
            
        case 20:
            return -0.21
            
        case 25:
            return -0.18
            
        case 30:
            return -0.15
            
        case 35:
            return -0.12
            
        case 40:
            return -0.09
            
        case 45:
            return -0.03
            
        case 50:
            return 0
            
        case 55:
            return 0.03
            
        case 60:
            return 0.09
            
        case 65:
            return 0.12
            
        case 70:
            return 0.15
            
        case 75:
            return 0.18
            
        case 80:
            return 0.21
            
        case 85:
            return 0.24
            
        case 90:
            return 0.27
            
        case 95:
            return 0.30
            
        case 100:
            return 0.33
            
            
        default:
            return 0
        }
    }
    
    var selectedDirection = Direction.up

    func startAnimating() {
        isAnimating = true

        withAnimation {
            sliderValue = ([-0.5, 0.5] as [CGFloat]).randomElement()!
        }
        
        withAnimation(Animation.easeInOut(duration: 0.5).repeatCount(5, autoreverses: true)) {
            sliderValue = 0 - sliderValue
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                let isWIn = CGFloat.random(in: 0..<1) < self.winChance + self.karmaBonus
                if isWIn {
                    self.sliderValue = self.selectedDirection == .down ? CGFloat.random(in: -0.5...(-0.3)) : CGFloat.random(in: 0.3...0.5)
                } else {
                    self.sliderValue = self.selectedDirection == .up ? CGFloat.random(in: -0.5...(-0.3)) : CGFloat.random(in: 0.3...0.5)
                }
                self.isAnimating = false
                self.showFinishScreen()
            }
        }
    }

    func showFinishScreen() {
        Task {
            if selectedDirection == .up && sliderValue > 0 ||
                selectedDirection == .down && sliderValue < 0 {
                gameResult = .win
            } else {
                gameResult = .lose
            }
            
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation {
                isFinishPresented = true
            }
            BalanceManager.shared.changeBalance(by: bet, gameResult: gameResult == .win ? .win : .lose)
        }
    }
    
    func restart() {
        sliderValue = 0
        isAnimating = false
        buttonDisabled = false
        isFinishPresented = false
        gameResult = .draw
        selectedDirection = Direction.up
    }
}
