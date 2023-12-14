//
//  Stage4Game2View.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

struct Stage4Game2View: View {
    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @StateObject var stage4Game2ViewModel = Stage4Game2ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage4Game2ViewModel.state {
            case .text0:
                stageView {
                    stage4Game2ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage4Game2ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage4Game2ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage4Game2ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage4Game2ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage4Game2ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage4Game2ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage4Game2ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage4Game2ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage4Game2ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage4Game2ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage4Game2ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage4Game2ViewModel.nextText(.text13)
                }
            case .text13:
                stageViewWithAnswers {
                    stage4ViewModel.setState(.game3)
                } negativeAction: {
                    stage4ViewModel.setState(.game3)
                }
            case .game:
                InvestmentView() {
                    stage4ViewModel.setState(.game3)
                }
            }
            
        }
        .onAppear {
            stage4ViewModel.setBackImages(
                background: "back",
                character: stage4Game2ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage4Game2ViewModel.state) { _ in
            stage4ViewModel.setBackImages(
                background: "back",
                character: stage4Game2ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage4Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game2ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage4Game2ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(customText: String? = nil, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(customText ?? stage4Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage4Game2ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game2ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage4Game2ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game2ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage4Game2ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage4Game2ViewModel.phraseSource.text {
            stage4Game2ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage4Game2ViewModel.printingFinished.toggle()
    }
    
}


