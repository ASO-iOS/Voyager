import SwiftUI

struct Stage1Game2View: View {
    
    @EnvironmentObject var stage1ViewModel: Stage1ViewModel
    @StateObject var stage1Game2ViewModel = Stage1Game2ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage1Game2ViewModel.state {
            case .text0:
                stageView {
                    stage1Game2ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage1Game2ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage1Game2ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage1Game2ViewModel.nextText(.game)
                }
            case .game:
                LoteryView(price: 100) {
                    stage1ViewModel.setState(.game3)
                }
                .environmentObject(LoteryViewModel())
            case .textSide0:
                stageView {
                    stage1Game2ViewModel.nextText(.textSide1)
                }
            case .textSide1:
                stageView {
                    stage1Game2ViewModel.nextText(.textSide2)
                }
            case .textSide2:
                stageViewWithAnswers {
                    stage1Game2ViewModel.index = 7
                    stage1Game2ViewModel.nextText(.textSideNeutral)
                } positiveAction: {
                    BalanceManager.shared.changeBalance(by: 100, gameResult: .lose)
                    StorageManager.shared.increaseKarma(5)
                    stage1Game2ViewModel.nextText(.textSidePositive)
                } negativeAction: {
                    stage1Game2ViewModel.index = 8
                    StorageManager.shared.reduceKarma(5)
                    stage1Game2ViewModel.nextText(.textSideNegative0)
                }
                
            case .textSidePositive:
                VStack {
                    Text("-100")
                        .gameButtonStyle(.textBack)
                        .padding(.top, 100)
                    stageView {
                        stage1ViewModel.setState(.game3)
                    }
                }
            case .textSideNeutral:
                stageView {
                    stage1ViewModel.setState(.game3)
                }
            case .textSideNegative0:
                
                stageView {
                    stage1Game2ViewModel.nextText(.textSideNegative1)
                }
            case .textSideNegative1:
                        
                stageView {
                    stage1Game2ViewModel.nextText(.textSideNegative2)
                }
            case .textSideNegative2:
                                
                stageView {
                    stage1Game2ViewModel.nextText(.textSideNegative3)
                }
            case .textSideNegative3:
                stageView {
                    stage1ViewModel.setState(.game3)
                }
            }
        }
        .onAppear {
            stage1ViewModel.setBackImages(
                background: "back",
                character: stage1Game2ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage1Game2ViewModel.state) { _ in
            stage1ViewModel.setBackImages(
                background: "back",
                character: stage1Game2ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage1Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game2ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage1Game2ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(neutralAction: @escaping () -> Void = {}, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(stage1Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage1Game2ViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game2ViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage1Game2ViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage1Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage1Game2ViewModel.printingFinished)
            .padding(.bottom)
            
            if let answerNeutral = stage1Game2ViewModel.phraseSource.answerNeutral {
                Button(action: {
                    neutralAction()
                }, label: {
                    Text(answerNeutral)
                        .gameButtonStyle(.nextButton)
                        .opacity(stage1Game2ViewModel.printingFinished ? 0.3 : 1.0)
                })
                .disabled(stage1Game2ViewModel.printingFinished)
                .padding(.bottom)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage1Game2ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage1Game2ViewModel.phraseSource.text {
            stage1Game2ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage1Game2ViewModel.printingFinished.toggle()
    }
    
}
