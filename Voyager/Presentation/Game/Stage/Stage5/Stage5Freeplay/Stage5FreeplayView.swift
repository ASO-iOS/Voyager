//
//  Stage5FreeplayView.swift
//  Voyager
//
//  Created by admin on 12/4/23.
//

import SwiftUI

struct Stage5FreePlayView: View {
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    @StateObject var stage5FreeplayViewModel = Stage5FreePlayViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage5FreeplayViewModel.state {
            case .main:
                VStack(spacing: 20) {
                    Text("Во что сыграем?")
                        .gameButtonStyle(.textBack)
                    
                    Button {
                        stage5FreeplayViewModel.state = .game1
                    } label: {
                        Text("Опционы")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage5FreeplayViewModel.state = .game2
                    } label: {
                        Text("Крипта")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage5FreeplayViewModel.state = .game3
                    } label: {
                        Text("Благотворительность")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage5FreeplayViewModel.state = .game4
                    } label: {
                        Text("Акции")
                            .gameButtonStyle(.nextButton)
                    }
                    
                    if BalanceManager.shared.balance > 11000 {
                        Button {
                            currentStageState.push(route: .stage2)
                            StorageManager.shared.setCurrentStage(.stage2)
                        } label: {
                            Text("К следующей главе ->")
                                .gameButtonStyle(.nextButton)
                        }
                        .padding(.top, 24)
                    } else {
                        Text("Чтобы перейти к финалу, накопите 11000 монет")
                            .gameButtonStyle(.textBack)
                            .padding(.top, 24)
                    }
                }
                .padding(.bottom)
                
            case .game1:
                OptionView() {
                    stage5FreeplayViewModel.state = .main
                }
            case .game2:
                CryptoView() {
                    stage5FreeplayViewModel.state = .main
                }
            case .game3:
                CharityView(completion: {
                    stage5FreeplayViewModel.state = .main
                })
            case .game4:
                StocksView() {
                    stage5FreeplayViewModel.state = .main
                }
            }
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
        .onChange(of: stage5FreeplayViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
    }
}

