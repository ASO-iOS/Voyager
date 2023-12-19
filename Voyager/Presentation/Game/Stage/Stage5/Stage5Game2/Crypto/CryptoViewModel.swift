//
//  CryptoViewModel.swift
//  MinigamesMZ
//
//  Created by mnats on 23.11.2023.
//

import SwiftUI

@MainActor
final class CryptoViewModel: ObservableObject {
    @Published var chartDatas: [[Double]] = []
    @Published var chartColors: [Color] = []
    @Published var minY: Double = 0
    @Published var maxY: Double = 100
    @Published var entryPoints: [Double] = []
    @Published var buttonDisabled = false
    @Published var isFinishPresented = false
    @Published var gameResult: GameResult = .draw
    @Published var winChance: Double = 0.2
    
    private var karmaBonus: Double {
        switch StorageManager.shared.gameKarma {
        case 0:
            return -0.17
            
        case 5:
            return -0.16
            
        case 10:
            return -0.14
            
        case 15:
            return -0.12
            
        case 20:
            return -0.10
            
        case 25:
            return -0.08
            
        case 30:
            return -0.06
            
        case 35:
            return -0.04
            
        case 40:
            return -0.02
            
        case 45:
            return -0.01
            
        case 50:
            return 0
            
        case 55:
            return 0.01
            
        case 60:
            return 0.02
            
        case 65:
            return 0.04
            
        case 70:
            return 0.06
            
        case 75:
            return 0.08
            
        case 80:
            return 0.10
            
        case 85:
            return 0.12
            
        case 90:
            return 0.14
            
        case 95:
            return 0.16
            
        case 100:
            return 0.17
            
            
        default:
            return 0
        }
    }
    
    var steps = 50
    var numberOfCharts: Int // Adjust this number for more or fewer charts
    private var initialChartColors: [Color] = []
    @Published var bet = 0
    
    let baseYValue: Double = 50
    let fluctuationRange: Double = 15

    init(numberOfCharts: Int = 1, winChance: Double = 0.2) {
        self.numberOfCharts = numberOfCharts
        self.winChance = winChance
        setupCharts()
        Task {
            await animateChart(delay: 0)
            buttonDisabled = false
        }
        restart()
    }

    private func setupCharts() {
        chartColors.append(.orange)
        chartColors.append(.cyan)
        chartColors.append(.yellow)
        chartColors.append(.pink)
        chartColors.append(.gray)
        chartColors.append(.brown)
        chartColors.shuffle()
        chartColors.insert(.blue, at: 0)
        initialChartColors = chartColors
        for _ in 0..<numberOfCharts {
            let initialData = [Double](repeating: 0, count: 36)
            chartDatas.append(initialData)
            entryPoints.append(0)
        }
    }
    
    private func moveChart(_ chartIndex: Int, offset: Double) {
        let lastValue = chartDatas[chartIndex].last!
        let nextValue = lastValue + offset
        let boundedValue = max(minY, min(maxY, nextValue))
        chartDatas[chartIndex].append(boundedValue)
        chartDatas[chartIndex].remove(at: 0)
        updateMinMaxValues()
    }

    func showFinishScreen() {
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation {
                isFinishPresented = true
            }
        }
    }

    private func updateMinMaxValues() {
        minY = chartDatas.flatMap { $0 }.min()! - 20
        maxY = chartDatas.flatMap { $0 }.max()! + 20
    }

    func win() {
        for i in 0..<numberOfCharts {
//            moveChart(i, offset: 50)
            chartColors[i] = .green
        }
        gameResult = .win
        showFinishScreen()
    }
    
    func lose() {
        for i in 0..<numberOfCharts {
//            moveChart(i, offset: -50)
            chartColors[i] = .red
        }
        gameResult = .lose
        showFinishScreen()
    }

    func restart() {
        buttonDisabled = false
        isFinishPresented = false
        chartColors = initialChartColors
    }

    private func animateChart(delay: Float = 0.05) async {
        let stages: [[Int]] = (0..<numberOfCharts).map { _ in Array(Array(2..<steps - 2).shuffled().prefix(7)) }
        buttonDisabled = true
        
        for i in 0..<numberOfCharts {
            entryPoints[i] = chartDatas[i].last!
        }
        
        for step in 1..<steps {
            for i in 0..<numberOfCharts {
                
                if stages[i].contains(step) {
                    entryPoints[i] += Double.random(in: -50...50)
                }
                let offset = Double.random(in: -fluctuationRange...fluctuationRange)
                moveChart(i, offset: offset)
            }
            updateMinMaxValues()
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
