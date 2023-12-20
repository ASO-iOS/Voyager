//
//  Stage1Game1View.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import SwiftUI

struct Stage1Game1View: View {
    @EnvironmentObject var stage1ViewModel: Stage1ViewModel
    @StateObject var stage1Game1ViewModel = Stage1Game1ViewModel()
    
    var body: some View {
        ZStack {
            switch stage1Game1ViewModel.state {
            case .text0:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.text6)
                }
            case .text6:
                stageViewWithAnswers(src: stage1Game1ViewModel.phraseSource.text, positiveAction: {
                    stage1Game1ViewModel.crossPut = true
                    stage1Game1ViewModel.nextText(.text7)
                }, negativeAction: {
                    stage1Game1ViewModel.crossPut = false
                    stage1Game1ViewModel.nextText(.text7)
                })
            case .text7:
                stageView(src: stage1Game1ViewModel.crossPut ? stage1Game1ViewModel.phraseSource.answerPositive ?? "" : stage1Game1ViewModel.phraseSource.answerNegative ?? "") {
                    stage1Game1ViewModel.nextText(.game)
                }
            case .game:
                ShellGameView(completion: {
                    stage1ViewModel.setState(.game2)
                })
                .environmentObject(ShellGameViewModel(cupsCount: 3, winChance: 0.7))
            case .textSide0:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.textSide1)
                }
            case .textSide1:
                    stageView(src: stage1Game1ViewModel.phraseSource.text) {
                        stage1Game1ViewModel.nextText(.textSide2)
                    }
            case .textSide2:
                stageViewWithAnswers(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.index = 11
                    stage1Game1ViewModel.nextText(.textSideNeutral)
                } positiveAction: {
                    StorageManager.shared.increaseKarma(5)
                    stage1Game1ViewModel.index = 12
                    stage1Game1ViewModel.nextText(.textSidePositive0)
                } negativeAction: {
                    BalanceManager.shared.changeBalance(by: 200, gameResult: .win)
                    StorageManager.shared.reduceKarma(5)
                    stage1Game1ViewModel.nextText(.textSideNegative)
                }


            case .textSideNegative:
                VStack {
                    Text("+200")
                        .gameButtonStyle(.textBack)
                        .padding(.top, 100)
                    stageView(src: stage1Game1ViewModel.phraseSource.text) {
                        stage1ViewModel.setState(.game2)
                    }
                }
            case .textSideNeutral:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1ViewModel.setState(.game2)
                }
            case .textSidePositive0:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.textSidePositive1)
                }
            case .textSidePositive1:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.textSidePositive2)
                }
            case .textSidePositive2:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    stage1Game1ViewModel.nextText(.textSidePositive3)
                }
            case .textSidePositive3:
                stageView(src: stage1Game1ViewModel.phraseSource.text) {
                    BalanceManager.shared.changeBalance(by: 100, gameResult: .win)
                    stage1Game1ViewModel.nextText(.textSidePositive4)
                }
            case .textSidePositive4:
                VStack {
                    Text("+100")
                        .gameButtonStyle(.textBack)
                        .padding(.top, 100)
                    stageView(src: stage1Game1ViewModel.phraseSource.text) {
                        stage1ViewModel.setState(.game2)
                    }
                }
            }
            
        }
        .onChange(of: stage1Game1ViewModel.state) { _ in
            stage1ViewModel.setBackImages(
                background: "back",
                character: stage1Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onAppear {
            stage1ViewModel.setBackImages(
                background: "back",
                character: stage1Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(src: String, nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage1Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game1ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage1Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols(src)
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(src: String, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(stage1Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage1Game1ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game1ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage1Game1ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game1ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage1Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols(src)
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(src: String, neutralAction: @escaping () -> Void = {}, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(stage1Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage1Game1ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game1ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage1Game1ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            if let answerNeutral = stage1Game1ViewModel.phraseSource.answerNeutral {
                Button(action: {
                    neutralAction()
                }, label: {
                    Text(answerNeutral)
                        .gameButtonStyle(.nextButton)
                        .opacity(stage1Game1ViewModel.printingFinished ? 0.3 : 1.0)
                })
                .disabled(stage1Game1ViewModel.printingFinished)
                .padding(.bottom)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage1Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols(src)
                }
                
            }
    }
    
    func writeTextBySymbols(_ src: String) async throws {
        for char in src {
            stage1Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(UInt64(StorageManager.shared.textSpeed)))
            }
        }
        stage1Game1ViewModel.printingFinished.toggle()
    }
    
}
