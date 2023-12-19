//
//  InvestmentViewModel.swift
//  MinigamesMZ
//
//  Created by mnats on 23.11.2023.
//

import SwiftUI

final class InvestmentViewModel: ObservableObject {
    @Published var bet = 0
    @MainActor func resetGame() {
        buttonDisabled = false
        isFinishPresented = false
        chartColor = .blue
    }
    
    @MainActor func startGame() async {
        resetGame()
        await animateChart(delay: 0)
        buttonDisabled = false
        try? await Task.sleep(nanoseconds: 200_000_000)
    }
    
    @Published var chartData: [Double] =  [
        04,04,05,08,05,08,06,03,37,35,75,38,40,37,37,36,40,38,40,38,41,35,83,81,80,53
    ]
    @Published var chartColor: Color = .blue
    @Published var minY: Double = 0
    @Published var maxY: Double = 100
    @Published var entryPoint: Double = 0
    @Published var buttonDisabled = false
    @Published var isFinishPresented = false
    @Published var gameResult: GameResult = .draw
    @Published var guaranteedWin = false
    @Published var winChance: Double = 0.6
    var steps = 50
    
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
    
    
    init(winChance: Double = 0.2) {
        self.winChance = winChance
    }
    
    func showFinishScreen() {
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation {
                isFinishPresented = true
            }
        }
    }
    
    private func moveUp(_ offset: Double = 50) {
        let endPoint = maxY + offset
        chartData.append(endPoint)
        chartData.remove(at: 0)
        minY = chartData.min()! - 20
        maxY = chartData.max()! + 20
    }
    
    private func moveDown(_ offset: Double = 50) {
        let endPoint = minY - offset
        chartData.append(endPoint)
        chartData.remove(at: 0)
        minY = chartData.min()! - 20
        maxY = chartData.max()! + 20
    }
    
    func win() {
        moveUp()
        chartColor = .green
        gameResult = .win
        showFinishScreen()
    }
    
    func lose() {
        moveDown()
        chartColor = .red
        gameResult = .lose
        showFinishScreen()
    }
    
    private func animateChart(delay: Float = 0.05) async {
        let stages: [Int] = Array(Array(2..<steps - 2).shuffled().prefix(7))
        buttonDisabled = true
        entryPoint = chartData.last!
        var currentEntryPoint = entryPoint
        withAnimation {
            chartColor = .blue
        }
        for i in 1..<steps {
            if stages.contains(i) {
                currentEntryPoint += Double.random(in: -50...50)
            }
            chartData.append(currentEntryPoint + Double.random(in: -3...3))
            chartData.remove(at: 0)
            minY = chartData.min()! - 20
            maxY = chartData.max()! + 20
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
    }
    
    func play() async {
        await animateChart()
        withAnimation {
            Double.random(in: 0...1) < winChance + karmaBonus ? win() : lose()
            BalanceManager.shared.changeBalance(by: bet, gameResult: gameResult == .win ? .win : .lose)
        }
    }
}
