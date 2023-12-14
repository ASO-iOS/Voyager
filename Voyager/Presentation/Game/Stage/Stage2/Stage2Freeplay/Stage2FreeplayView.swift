//
//  Stage2FreeplayView.swift
//  Voyager
//
//  Created by admin on 12/1/23.
//

import SwiftUI

struct Stage2FreeplayView: View {
    
    
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    @StateObject var stage2FreeplayViewModel = Stage2FreePlayViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage2FreeplayViewModel.state {
            case .main:
                VStack(spacing: 20) {
                    Text("Во что сыграем?")
                        .gameButtonStyle(.textBack)
                    
                    Button {
                        stage2FreeplayViewModel.state = .game1
                    } label: {
                        Text("Рулетка")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage2FreeplayViewModel.state = .game2
                    } label: {
                        Text("Кости")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage2FreeplayViewModel.state = .game3
                    } label: {
                        Text("Сложные наперстки")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage2FreeplayViewModel.state = .game4
                    } label: {
                        Text("Ставки на спорт")
                            .gameButtonStyle(.nextButton)
                    }
                    Button(action: {
                        currentStageState.push(route: .stage3)
                        StorageManager.shared.setCurrentStage(.stage3)
                    }, label: {
                        Text("Stage 3")
                    })
                }
                .padding(.bottom)
                
            case .game1:
                WheelView() {
                    stage2FreeplayViewModel.state = .main
                }
                    .environmentObject(WheelViewModel())
            case .game2:
                DiceView() {
                    stage2FreeplayViewModel.state = .main
                }
                .environmentObject(DiceViewViewModel())
            case .game3:
                ShellGameView(completion: {
                    stage2FreeplayViewModel.state = .main
                })
                .environmentObject(ShellGameViewModel(cupsCount: 5, winChance: 0.2))
            case .game4:
                OriginalSportBettingView() {
                    stage2FreeplayViewModel.state = .main
                }
                .environmentObject(OriginalSportBettingViewModel())
            }
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
        .onChange(of: stage2FreeplayViewModel.state) { _ in
            stage2ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
    }
}


