//
//  Stage4Game1View.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

struct Stage4Game1View: View {
    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @StateObject var stage4Game1ViewModel = Stage4Game1ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage4Game1ViewModel.state {
            case .text0:
                stageView {
                    stage4Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage4Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage4Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage4Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage4Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage4Game1ViewModel.nextText(.text6)
                }
            case .text6:
                stageViewWithAnswers {
                    stage4Game1ViewModel.nextText(.game)
                } negativeAction: {
                    stage4Game1ViewModel.nextText(.game)
                }

            case .game:
                LoteryView() {
                    stage4ViewModel.setState(.game2)
                }
                .environmentObject(LoteryViewModel())
            }
            
        }
        .onAppear {
            stage4ViewModel.setBackImages(
                background: "back",
                character: stage4Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage4Game1ViewModel.state) { _ in
            stage4ViewModel.setBackImages(
                background: "back",
                character: stage4Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage4Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                stage4Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(customText: String? = nil, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(customText ?? stage4Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage4Game1ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game1ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage4Game1ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage4Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage4Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage4Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage4Game1ViewModel.phraseSource.text {
            stage4Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage4Game1ViewModel.printingFinished.toggle()
    }
    
}


