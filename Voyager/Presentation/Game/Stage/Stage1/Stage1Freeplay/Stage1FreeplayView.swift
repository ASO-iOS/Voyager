//
//  Stage1FreeplayView.swift
//  Voyager
//
//  Created by admin on 13.12.2023.
//

import SwiftUI

struct Stage1FreeplayView: View {
    
    
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage1ViewModel: Stage1ViewModel
    @StateObject var stage1FreeplayViewModel = Stage1FreeplayViewModel()
    
    var body: some View {
        ZStack {
            switch stage1FreeplayViewModel.state {
            case .main:
                VStack(spacing: 20) {
                    Text("Во что сыграем?")
                        .gameButtonStyle(.textBack)
                    
                    Button {
                        stage1FreeplayViewModel.state = .game1
                    } label: {
                        Text("Наперстки")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage1FreeplayViewModel.state = .game2
                    } label: {
                        Text("Лотерея")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage1FreeplayViewModel.state = .game3
                    } label: {
                        Text("Камень-Бумага-Ножницы")
                            .gameButtonStyle(.nextButton)
                    }
                    Button {
                        stage1FreeplayViewModel.state = .game4
                    } label: {
                        Text("Спор с незнакомцем")
                            .gameButtonStyle(.nextButton)
                    }
                    
                    Button(action: {
                        
                            currentStageState.push(route: .stage2)
                            StorageManager.shared.setCurrentStage(.stage2)
                    }, label: {
                        Text("Stage 2")
                    })
                }
                .padding(.bottom)
                
            case .game1:
                ShellGameView(completion: {
                    stage1FreeplayViewModel.state = .main
                })
                .environmentObject(ShellGameViewModel(cupsCount: 3, winChance: 0.3))
            case .game2:
                LoteryView(price: 100) {
                    stage1FreeplayViewModel.state = .main
                }
                .environmentObject(LoteryViewModel())
            case .game3:
                SRPView() {
                    stage1FreeplayViewModel.state = .main
                }
                .environmentObject(SPRViewModel())
                .onAppear {
                    stage1ViewModel.character = PhraseType.students.imageName
                }
            case .game4:
                BetWithStrangerView(winChance: 0.5) {
                    stage1FreeplayViewModel.state = .main
                }
            }
        }
        .onAppear {
            stage1ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
        .onChange(of: stage1FreeplayViewModel.state) { _ in
            stage1ViewModel.setBackImages(
                background: "back",
                character: ""
            )
        }
    }
}

