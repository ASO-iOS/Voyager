//
//  StorageManager.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    @AppStorage(SMKeys.IS_FIRST_TIME_PLAYING) private(set) var isFirstTimePlaying = true
    
    func firstGamePlayed() {
        isFirstTimePlaying = false
    }
    
    func resetFirstGamePlayed() {
        isFirstTimePlaying = true
    }
    
    //MARK: - onboarding
    
    @AppStorage(SMKeys.ONBOARDING_PRESENTED) private(set) var onboardingPresented = false
    
    func toggleOnboarding() {
        onboardingPresented.toggle()
    }
    
    @AppStorage(SMKeys.GAME_TEXT_SIZE) private(set) var textSize = 14
    
    func textSizeDown() {
        if textSize > 9 {
            textSize -= 1
        }
        
    }
    
    func textSizeUp() {
        if textSize < 24 {
            textSize += 1
        }
       
    }
    
    @AppStorage(SMKeys.GAME_TEXT_SPEED) private(set) var textSpeed  = 10_000_000
    func textSpeedDown() {
        if textSpeed > 1_000_000 {
            textSpeed -= 1_000_000
        }
        
    }
    func textSpeedUp() {
        if textSpeed < 100_000_000 {
            textSpeed += 1_000_000
        }
    }
    
    //MARK: - stage state
    
    @AppStorage(SMKeys.STAGE_1_STATE) private(set) var stage1State = GameStageState.preview
    @AppStorage(SMKeys.STAGE_2_STATE) private(set) var stage2State = GameStageState.preview
    @AppStorage(SMKeys.STAGE_3_STATE) private(set) var stage3State = GameStageState.preview
    @AppStorage(SMKeys.STAGE_4_STATE) private(set) var stage4State = GameStageState.preview
    @AppStorage(SMKeys.STAGE_5_STATE) private(set) var stage5State = GameStageState.preview
    
    func setStage1State(_ state: GameStageState) {
        stage1State = state
    }
    
    func setStage2State(_ state: GameStageState) {
        stage2State = state
    }
    
    func setStage3State(_ state: GameStageState) {
        stage3State = state
    }
    
    func setStage4State(_ state: GameStageState) {
        stage4State = state
    }
    
    func setStage5State(_ state: GameStageState) {
        stage5State = state
    }
    
    //MARK: - current stage
    
    @AppStorage(SMKeys.CURRENT_STAGE) private(set) var currentStageState = CurrentStageState.stage1
    
    func setCurrentStage(_ stage: CurrentStageState) {
        currentStageState = stage
    }
    
    //MARK: - karma
    
    @AppStorage(SMKeys.GAME_KARMA) private(set) var gameKarma = 50
    
    func increaseKarma(_ value: Int) {
        if gameKarma < 100 {
            gameKarma += value
        }
    }
    
    func reduceKarma(_ value: Int) {
        if gameKarma > 0 {
            gameKarma -= value
        }
    }
    
    func resetKarma() {
        gameKarma = 50
    }
    
    @AppStorage(SMKeys.IS_NEW_GAME) private(set) var isNewGame = true
    
    func toggleIsNewGame() {
        isNewGame.toggle()
    }
    
    
    
    //MARK: - cash
    
//    @AppStorage(SMKeys.GAME_CASH) private(set) var gameCash = 50
//    
//    func setCash(_ value: Int) {
//        gameCash = value
//    }
    
    
}

enum GameResultImpl {
    case win, lose
}

class BalanceManager: ObservableObject {
    @AppStorage(SMKeys.GAME_CASH) private(set) var gameCash = 0
    @AppStorage(SMKeys.LOW_BALANCE_0) private(set) var lowBalance0 = false
    @Published var balance = 0
    @Published var lowBalance = false
    
    static let shared = BalanceManager()
    
    private init() {
        balance = gameCash
        lowBalance = lowBalance0
    }
    
    func changeBalance(by value: Int, gameResult: GameResultImpl) {
        let temp = balance
        switch gameResult {
        case .win:
            balance += value
            gameCash = balance
        case .lose:
            if temp - value >= 0 {
                balance -= value
                gameCash = balance
            } else {
                lowBalance.toggle()
                lowBalance0 = lowBalance
            }
        }
    }
    
    func reset() {
        gameCash = 0
        balance = gameCash
        resetLowBalance()
    }
    
    func resetLowBalance() {
        lowBalance = false
        lowBalance0 = lowBalance
    }
}
