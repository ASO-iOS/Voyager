//
//  DiceViewModel.swift
//  dices
//
//  Created by mnats on 20.11.2023.
//

import SwiftUI

@MainActor
class DiceViewViewModel: ObservableObject {
    @Published var diceRotation: CGFloat
    @Published var diceRotating: Bool
    @Published var playerFaces: [String]
    @Published var enemyFaces: [String]
    @Published var score: (Int, Int)
    @Published var gameResult: GameResult
    @Published var winChance = 0.5
    @Published var isFinishPresented: Bool = false
    @Published var bet: Int = 0
    
    private var karmaBonus: Double  {
        switch StorageManager.shared.gameKarma {
        case 0:
            return -0.45
            
        case 5:
            return -0.40
            
        case 10:
            return -0.35
            
        case 15:
            return -0.30
            
        case 20:
            return -0.25
            
        case 25:
            return -0.20
            
        case 30:
            return -0.15
            
        case 35:
            return -0.10
            
        case 40:
            return -0.07
            
        case 45:
            return -0.03
            
        case 50:
            return 0
            
        case 55:
            return 0.03
            
        case 60:
            return 0.07
            
        case 65:
            return 0.10
            
        case 70:
            return 0.15
            
        case 75:
            return 0.20
            
        case 80:
            return 0.25
            
        case 85:
            return 0.30
            
        case 90:
            return 0.35
            
        case 95:
            return 0.40
            
        case 100:
            return 0.45
            
            
        default:
            return 0
        }
    }

    private var faces: [String]
    
    init(diceAmount: Int = 1, winChance: Double = 0.5) {
        self.diceRotation = 0
        self.diceRotating = false
        self.score = (0, 0)
        self.gameResult = .draw
        self.winChance = winChance
        self.faces = ["1", "2", "3", "4", "5", "6"]
        self.playerFaces = [String](repeating: "1", count: diceAmount)
        self.enemyFaces = [String](repeating: "1", count: diceAmount)
    }
    
    
    func resetGame() {
        score = (0,0)
        isFinishPresented = false
    }

    func rotate(_ count: Int, duration: TimeInterval = 1.5) async {
        withAnimation(.easeOut(duration: duration)) {
            diceRotation += 360 * CGFloat(count)
        }
        try? await Task.sleep(nanoseconds: UInt64(duration * 1000_000_000))
        return
    }

    func rollDice() {
        guard !diceRotating else { return }
        diceRotating = true
        Task {
            await rotate(2)
            for i in 0..<playerFaces.count {
                playerFaces[i] = faces.randomElement()!
            }
            
            for i in 0..<enemyFaces.count {
                enemyFaces[i] = faces.randomElement()!
            }
            
            if winChance + karmaBonus > Double.random(in: 0..<1) {
                while playerFaces.reduce(0, {$0 + (Int($1) ?? 0)}) <= enemyFaces.reduce(0, {$0 + (Int($1) ?? 0)}) {
                    for i in 0..<playerFaces.count {
                        playerFaces[i] = faces.randomElement()!
                    }
                    
                    for i in 0..<enemyFaces.count {
                        enemyFaces[i] = faces.randomElement()!
                    }
                }
            }
            
            score = (playerFaces.reduce(0) {$0 + (Int($1) ?? 0)},
                     enemyFaces.reduce(0) {$0 + (Int($1) ?? 0)})
            
            
            
            diceRotating = false
            
            gameResult = score.0 == score.1 ? .draw : score.0 > score.1 ? .win : .lose
            try? await Task.sleep(nanoseconds: UInt64(2000_000_000))
            isFinishPresented = true
            if gameResult != .draw {
                BalanceManager.shared.changeBalance(by: bet, gameResult: gameResult == .win ? .win : .lose)
            }

//            try? await Task.sleep(nanoseconds: UInt64(1000_000_000))
        }
    }
}
