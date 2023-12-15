//
//  ClickerViewModel.swift
//  MinigamesMZ
//
//  Created by mnats on 29.11.2023.
//

import SwiftUI

final class ClickerViewModel: ObservableObject {
    @Published var offsetY: CGFloat = 0
    @Published var label = "Ну давай!"
    @Published var isFinishPresented = false
    @Published var gameResult: GameResult = .draw
    @Published var bet = 0
    
    var timer: Timer?
    
    func reset() {
        offsetY = 0
        label = "Ну давай!"
        isFinishPresented = false
        gameResult = .draw
        timer = nil
    }

    func onTapGesture() {
        if offsetY >= -150 && offsetY < 150 && (timer?.isValid ?? false) {
            withAnimation {
                offsetY -= 5
            }
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            withAnimation {
                self?.offsetY += 5
            }
        }
    }

    func checkOffset() {
        withAnimation {
            if offsetY <= -140 {
                label = "Признаю, ты был прав..."
                timer?.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                    self?.gameResult = .win
                    self?.isFinishPresented = true
                    BalanceManager.shared.changeBalance(by: self?.bet ?? 100, gameResult: .win)
                })
//                Task {
//                    try? await Task.sleep(nanoseconds: 2_000_000_000)
//                    gameResult = .win
//                    isFinishPresented = true
//                    
//                }
            } else if offsetY > 140 {
                label = "Больше тут не появляйся, звездабол..."
                timer?.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                    self?.gameResult = .lose
                    self?.isFinishPresented = true
                    BalanceManager.shared.changeBalance(by: self?.bet ?? 100, gameResult: .lose)
                })
//                Task {
//                    try? await Task.sleep(nanoseconds: 2_000_000_000)
//                    gameResult = .lose
//                    isFinishPresented = true
//                    
//                }
            }
            updateLabelBasedOnOffset()
        }
    }

    private func updateLabelBasedOnOffset() {
        switch offsetY {
        case -120 ..< -90:
            label = "Ты похож на мудреца, друг"
        case -80 ..< -50:
            label = "Черт, все сходится!"
        case -40 ..< -10:
            label = "Ровно стелешь, однако"
        case 0..<30:
            label = "Не убедил, попробуй еще раз что-ли?"
        case 40..<70:
            label = "Не врешь ли ты часом, дружок?"
        case 80..<120:
            label = "Пойман за руку, дешевка!"
        default:
            break
        }
    }
}
