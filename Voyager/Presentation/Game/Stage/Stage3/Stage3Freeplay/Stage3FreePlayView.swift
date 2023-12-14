//
//  Stage3FreeplayView.swift
//  Voyager
//
//  Created by admin on 13.12.2023.
//

import SwiftUI

struct Stage3FreePlayView: View {
    
    
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @StateObject var stage3FreeplayViewModel = Stage3FreePlayViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage3FreeplayViewModel.state {
            case .main:
                VStack(spacing: 20) {
                    Text("Во что сыграем?")
                        .gameButtonStyle(.textBack)
                    
                    Button {
                        stage3FreeplayViewModel.state = .game1
                    } label: {
                        Text("Ипподром")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage3FreeplayViewModel.state = .game2
                    } label: {
                        Text("21")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage3FreeplayViewModel.state = .game3
                    } label: {
                        Text("Усложненные ставки")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage3FreeplayViewModel.state = .game4
                    } label: {
                        Text("Усложненная рулетка")
                            .gameButtonStyle(.nextButton)
                    }
                    Button(action: {
                        currentStageState.push(route: .stage4)
                        StorageManager.shared.setCurrentStage(.stage4)
                    }, label: {
                        Text("Stage 4")
                    })
                }
                .padding(.bottom)
                
            case .game1:
                MexicoHippodromView() {
                    stage3FreeplayViewModel.state = .main
                }
                    .environmentObject(MexicoHippodromViewModel())
            case .game2:
                TwentyOneView() {
                    stage3FreeplayViewModel.state = .main
                }
            case .game3:
                UpdetedSportBettingView() {
                    stage3FreeplayViewModel.state = .main
                }
                    .environmentObject(UpdetedSportBettingViewModel())
            case .game4:
                WheelComplicatedView() {
                    stage3FreeplayViewModel.state = .main
                }
                    .environmentObject(WheelComplicatedViewModel())
            }
        }
        .onAppear {
            stage3ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
        .onChange(of: stage3FreeplayViewModel.state) { _ in
            stage3ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
    }
}

