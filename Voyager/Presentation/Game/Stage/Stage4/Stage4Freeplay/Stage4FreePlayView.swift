//
//  Stage4FreePlayView.swift
//  Voyager
//
//  Created by admin on 14.12.2023.
//

import SwiftUI

struct Stage4FreePlayView: View {
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @StateObject var stage4FreeplayViewModel = Stage4FreePlayViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage4FreeplayViewModel.state {
            case .main:
                VStack(spacing: 20) {
                    Text("Во что сыграем?")
                        .gameButtonStyle(.textBack)
                    
                    Button {
                        stage4FreeplayViewModel.state = .game1
                    } label: {
                        Text("Лотерейный билет")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage4FreeplayViewModel.state = .game2
                    } label: {
                        Text("Инвестирование")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage4FreeplayViewModel.state = .game3
                    } label: {
                        Text("Игровой автомат")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage4FreeplayViewModel.state = .game4
                    } label: {
                        Text("Пари")
                            .gameButtonStyle(.nextButton)
                    }
                    Button(action: {
                        currentStageState.push(route: .stage5)
                        StorageManager.shared.setCurrentStage(.stage5)
                    }, label: {
                        Text("Stage 4")
                    })
                }
                .padding(.bottom)
                
            case .game1:
                LoteryView(price: 1000) {
                    stage4FreeplayViewModel.state = .main
                }
                .environmentObject(LoteryViewModel())
            case .game2:
                InvestmentView() {
                    stage4FreeplayViewModel.state = .main
                }
            case .game3:
                SlotMashineView(depositArray: [100, 250, 500, 1000], betAmount: 25, completion: {
                    stage4FreeplayViewModel.state = .main
                })
            case .game4:
                ClickerView() {
                    stage4FreeplayViewModel.state = .main
                }
            }
        }
        .onAppear {
            stage4ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
        .onChange(of: stage4FreeplayViewModel.state) { _ in
            stage4ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
    }
}
