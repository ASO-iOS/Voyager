//
//  Stage4Game3View.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

struct Stage4Game3View: View {
    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @StateObject var stage4Game3ViewModel = Stage4Game3ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage4Game3ViewModel.state {
            case .text0:
                stageView {
                    stage4Game3ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage4Game3ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage4Game3ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage4Game3ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage4Game3ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage4Game3ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage4Game3ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage4Game3ViewModel.nextText(.game)
                }
            case .game:
                SlotMashineView(depositArray: [100, 250, 500, 1000], betAmount: 25, completion: {
                    stage4ViewModel.setState(.game4)
                })
            case .textSide0:
                stageView {
                    stage4Game3ViewModel.nextText(.textSide1)
                }
            case .textSide1:
                stageViewWithAnswers {
                    stage4Game3ViewModel.index = 12
                    stage4Game3ViewModel.nextText(.textSideNeutral)
                } positiveAction: {
                    stage4Game3ViewModel.index = 13
                    stage4Game3ViewModel.nextText(.textSidePositive0)
                } negativeAction: {
                    stage4Game3ViewModel.nextText(.textSideNegative0)
                }

            case .textSideNegative0:
                stageView {
                    BalanceManager.shared.changeBalance(
                        by: BalanceManager.shared.gameCash / 2,
                        gameResult: .lose)
                    stage4Game3ViewModel.nextText(.textSideNegative1)
                }
            case .textSideNegative1:
                stageView {
                    stage4ViewModel.setState(.game4)
                }
            case .textSideNeutral:
                stageView {
                    stage4ViewModel.setState(.game4)
                }
            case .textSidePositive0:
                stageView {
                    BalanceManager.shared.changeBalance(
                        by: 2000,
                        gameResult: .win)
                    stage4Game3ViewModel.nextText(.textSidePositive1)
                }
            case .textSidePositive1:
                stageView {
                    stage4ViewModel.setState(.game4)
                }
            }
            
        }
        .onAppear {
            stage4ViewModel.setBackImages(
                background: "back3",
                character: stage4Game3ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage4Game3ViewModel.state) { _ in
            stage4ViewModel.setBackImages(
                background: "back3",
                character: stage4Game3ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage4Game3ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game3ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game3ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage4Game3ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(neutralAction: @escaping () -> Void = {}, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(stage4Game3ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage4Game3ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game3ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game3ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage4Game3ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game3ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game3ViewModel.printingFinished)
            .padding(.bottom)
            
            if let answerNeutral = stage4Game3ViewModel.phraseSource.answerNeutral {
                Button(action: {
                    neutralAction()
                }, label: {
                    Text(answerNeutral)
                        .gameButtonStyle(.nextButton)
                        .opacity(stage4Game3ViewModel.printingFinished ? 0.3 : 1.0)
                })
                .disabled(stage4Game3ViewModel.printingFinished)
                .padding(.bottom)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage4Game3ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage4Game3ViewModel.phraseSource.text {
            stage4Game3ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage4Game3ViewModel.printingFinished.toggle()
    }
    
}


