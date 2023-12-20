//
//  SettingsView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settinsViewModel: SettingsViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
    @State private var showingResetAlert = false
    @State private var showingFullResetAlert = false
    
    var body: some View {

        ZStack {
//            Image("backPreview")
//                .resizable()
//                .ignoresSafeArea(.all)
            
            VStack {
                
                HStack {
                    Button(action: {
                        appRouter.pop()
                    }, label: {
                        Image("backArrow")
                            .resizable()
                            .frame(width: 20, height: 30)
                            .padding()
                    })
                    
                    Spacer()
                }
                .padding()
                
                settingsButtomView("Скорость текста") {
                    appRouter.push(route: .textSpeed)
                }
                
                settingsButtomView("Размер шрифта") {
                    appRouter.push(route: .textSize)
                }
                
                
                settingsButtomView("Сброс прогресса") {
                    showingResetAlert = true
                } .alert(isPresented: $showingResetAlert, content: {
                    Alert(title: Text("Сброс прогресса"), message: Text("Вы точно хотите очистить весь прогресс игры и начать сначала? (Деньги при этом сохранятся"), primaryButton: .destructive(Text("Да, я уверен"), action: {
                        resetProgress()
                    }), secondaryButton: .cancel())
                })
                
                settingsButtomView("Сброс прогресса и валюты") {
                    showingFullResetAlert = true
                } .alert(isPresented: $showingFullResetAlert, content: {
                    Alert(title: Text("Полный сброс прогресса"), message: Text("Вы точно хотите очистить весь прогресс игры и начать сначала? (Деньги при этом так же будут утеряны"), primaryButton: .destructive(Text("Да, я уверен"), action: {
                        resetProgressWithMoney()
                    }), secondaryButton: .cancel())
                })
                
                Spacer()
                
            }
        }
    }
    
    func resetProgress() {
        StorageManager.shared.setCurrentStage(CurrentStageState.stage1)
        StorageManager.shared.setStage1State(GameStageState.preview)
        StorageManager.shared.setStage2State(GameStageState.preview)
        StorageManager.shared.setStage3State(GameStageState.preview)
        StorageManager.shared.setStage4State(GameStageState.preview)
        StorageManager.shared.setStage5State(GameStageState.preview)
        StorageManager.shared.resetKarma()
        StorageManager.shared.toggleIsNewGame()
        StorageManager.shared.resetFirstGamePlayed()
        BalanceManager.shared.lowBalance = false
        currentStageState.route = .stage1
        
        
    }
    
    func resetProgressWithMoney() {
        StorageManager.shared.setCurrentStage(CurrentStageState.stage1)
        StorageManager.shared.setStage1State(GameStageState.preview)
        StorageManager.shared.setStage2State(GameStageState.preview)
        StorageManager.shared.setStage3State(GameStageState.preview)
        StorageManager.shared.setStage4State(GameStageState.preview)
        StorageManager.shared.setStage5State(GameStageState.preview)
        StorageManager.shared.resetFirstGamePlayed()
        StorageManager.shared.resetKarma()
        currentStageState.route = .stage1
        BalanceManager.shared.reset()
        StorageManager.shared.toggleIsNewGame()
    }
    
    
    @ViewBuilder private func settingsButtomView(_ text: String, action: @escaping() -> Void ) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .frame(height: 46)
                .font(.system(size: 21))
                .gameButtonStyle(.nextButton)
        })
        .padding(.bottom, 12)
    }
}
