//
//  Stage1Game1View.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import SwiftUI

struct Stage3Game1View: View {
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @StateObject var stage3Game1ViewModel = Stage3Game1ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage3Game1ViewModel.state {
            case .text0:
                stageView {
                    stage3Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage3Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage3Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage3Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage3Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage3Game1ViewModel.nextText(.game)
                }
            case .game:
                MexicoHippodromView() {
                    stage3ViewModel.setState(.game2)
                } .environmentObject(MexicoHippodromViewModel())
            case .textSide0:
                stageView {
                    stage3Game1ViewModel.nextText(.textSide1)
                }
            case .textSide1:
                stageView {
                    stage3Game1ViewModel.nextText(.textSide2)
                }
            case .textSide2:
                stageView {
                    stage3Game1ViewModel.nextText(.textSide3)
                }
            case .textSide3:
                stageViewWithAnswers {
                    stage3Game1ViewModel.index = 10
                    stage3Game1ViewModel.nextText(.textSideNeutral)
                } positiveAction: {
                    BalanceManager.shared.changeBalance(by: 500, gameResult: .win)
                    stage3Game1ViewModel.index = 10
                    stage3Game1ViewModel.nextText(.textSidePositive)
                } negativeAction: {
                    BalanceManager.shared.changeBalance(
                        by: BalanceManager.shared.gameCash,
                        gameResult: .lose)
                    BalanceManager.shared.changeBalance(by: 500, gameResult: .win)
                    stage3Game1ViewModel.nextText(.textSideNegative)
                }

            case .textSideNegative:
                stageView {
                    stage3ViewModel.setState(.game2)
                }
            case .textSideNeutral:
                stageView {
                    stage3ViewModel.setState(.game2)
                }
            case .textSidePositive:
                Text("+500")
                    .gameButtonStyle(.textBack)
                stageView {
                    stage3ViewModel.setState(.game2)
                }
            }
            
        }
        .onAppear {
            stage3ViewModel.setBackImages(
                background: "back4",
                character: stage3Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage3Game1ViewModel.state) { _ in
            stage3ViewModel.setBackImages(
                background: "back12",
                character: stage3Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage3ViewModel.skipText()
                }
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game1ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage3Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(neutralAction: @escaping () -> Void = {}, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage3ViewModel.skipText()
                }
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage3Game1ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game1ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage3Game1ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            if let answerNeutral = stage3Game1ViewModel.phraseSource.answerNeutral {
                Button(action: {
                    neutralAction()
                }, label: {
                    Text(answerNeutral)
                        .gameButtonStyle(.nextButton)
                        .opacity(stage3Game1ViewModel.printingFinished ? 0.3 : 1.0)
                })
                .disabled(stage3Game1ViewModel.printingFinished)
                .padding(.bottom)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage3Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage3Game1ViewModel.phraseSource.text {
            stage3Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: stage3ViewModel.delay)
            }
        }
        stage3Game1ViewModel.printingFinished.toggle()
        stage3ViewModel.resetDelay()
    }
    
}

