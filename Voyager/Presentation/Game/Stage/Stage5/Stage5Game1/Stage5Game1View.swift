import SwiftUI

struct Stage5Game1View: View {
    
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    @StateObject var stage5Game1ViewModel = Stage5Game1ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            
            switch stage5Game1ViewModel.state {
            case .text0:
                stageView {
                    stage5Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage5Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage5Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage5Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage5Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage5Game1ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage5Game1ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage5Game1ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage5Game1ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage5Game1ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage5Game1ViewModel.nextText(.game)
                }
            case .game:
                OptionView() {
                    stage5ViewModel.setState(.game2)
                }
            case .textSide0:
                stageView {
                    stage5Game1ViewModel.nextText(.textSide1)
                }
            case .textSide1:
                stageView {
                    stage5Game1ViewModel.nextText(.textSide2)
                }
            case .textSide2:
                stageView {
                    stage5Game1ViewModel.nextText(.textSide3)
                }
            case .textSide3:
                stageViewWithAnswers {
                    stage5Game1ViewModel.nextText(.textSideNeutral)
                } positiveAction: {
                    stage5Game1ViewModel.index = 15
                    BalanceManager.shared.changeBalance(by: 5000, gameResult: .win)
                    StorageManager.shared.increaseKarma(5)
                    stage5Game1ViewModel.nextText(.textSidePositive)
                } negativeAction: {
                    StorageManager.shared.reduceKarma(5)
                    stage5Game1ViewModel.index = 16
                    stage5Game1ViewModel.nextText(.textSideNegative0)
                }

            case .textSideNeutral:
                stageView {
                    stage5ViewModel.setState(.game2)
                }
            case .textSidePositive:
                Text("+5000")
                    .gameButtonStyle(.textBack)
                stageView {
                    stage5ViewModel.setState(.game2)
                }
            case .textSideNegative0:
                stageView {
                    stage5Game1ViewModel.nextText(.textSideNegative1)
                }
            case .textSideNegative1:
                stageView {
                    stage5Game1ViewModel.nextText(.textSideNegative2)
                }
            case .textSideNegative2:
                stageView {
                    stage5Game1ViewModel.nextText(.textSideNegative3)
                }
            case .textSideNegative3:
                stageView {
                    stage5Game1ViewModel.nextText(.textSideNegative4)
                }
            case .textSideNegative4:
                stageView {
                    stage5Game1ViewModel.nextText(.textSideNegative5)
                }
            case .textSideNegative5:
                stageView {
                    stage5Game1ViewModel.nextText(.textSideNegative6)
                }
            case .textSideNegative6:
                stageView {
                    stage5ViewModel.setState(.game2)
                }
            }
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back17",
                character: stage5Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage5Game1ViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back11",
                character: stage5Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage5ViewModel.skipText()
                }
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            stage5Game1ViewModel.printingFinished.toggle()
            Task {
                try await writeTextBySymbols()
            }
        }
    }
    
    @ViewBuilder private func stageViewWithAnswers(neutralAction: @escaping () -> Void = {}, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage5ViewModel.skipText()
                }
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage5Game1ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5Game1ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage5Game1ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            if let answerNeutral = stage5Game1ViewModel.phraseSource.answerNeutral {
                Button(action: {
                    neutralAction()
                }, label: {
                    Text(answerNeutral)
                        .gameButtonStyle(.nextButton)
                        .opacity(stage5Game1ViewModel.printingFinished ? 0.3 : 1.0)
                })
                .disabled(stage5Game1ViewModel.printingFinished)
                .padding(.bottom)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage5Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage5Game1ViewModel.phraseSource.text {
            stage5Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: stage5ViewModel.delay)
            }
        }
        stage5Game1ViewModel.printingFinished.toggle()
        stage5ViewModel.resetDelay()
    }
    
    
}
