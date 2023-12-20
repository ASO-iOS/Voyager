//
//  FinalView.swift
//  Voyager
//
//  Created by admin on 20.12.2023.
//

import SwiftUI

struct FinalView: View {
    @StateObject var finalViewModel = FinalViewModel()
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    var body: some View {
        ZStack {
            Image(finalViewModel.background)
                .resizable()
                .ignoresSafeArea(.all)
            if !finalViewModel.character.isEmpty {
                Image(finalViewModel.character)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
            }
            ArrowBalanceView {
                appRouter.pop()
            }
            switch finalViewModel.state {
            case .text0:
                stageView {
                    finalViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    finalViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    finalViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    finalViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    finalViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    finalViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    finalViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    finalViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    finalViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    finalViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    finalViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    finalViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    finalViewModel.nextText(.text13)
                }
            case .text13:
                stageView {
                    finalViewModel.nextText(.text14)
                }
            case .text14:
                stageView {
                    finalViewModel.nextText(.text15)
                }
            case .text15:
                stageView {
                    finalViewModel.nextText(.text16)
                }
            case .text16:
                stageView {
                    finalViewModel.nextText(.text17)
                }
            case .text17:
                stageView {
                    finalViewModel.nextText(.text18)
                }
            case .text18:
                stageView {
                    finalViewModel.nextText(.text19)
                }
            case .text19:
                stageView {
                    finalViewModel.nextText(.text20)
                }
            case .text20:
                stageView {
                    finalViewModel.nextText(.text21)
                }
            case .text21:
                stageView {
                    finalViewModel.nextText(.text22)
                }
            case .text22:
                stageViewWithAnswers(
                    positiveAction: {
                        finalViewModel.nextText(.text0n)
                    },
                    negativeAction: {
                        finalViewModel.nextText(.textDD)
                    }
                )
            case .textDD:
                stageView {
                    finalViewModel.nextText(.text20)
                }
            case .text0n:
                stageView {
                    finalViewModel.nextText(.text1n)
                }
            case .text1n:
                stageView {
                    finalViewModel.nextText(.text2n)
                }
            case .text2n:
                stageView {
                    finalViewModel.nextText(.text3n)
                }
            case .text3n:
                stageView {
                    finalViewModel.nextText(.text4n)
                }
            case .text4n:
                stageView {
                    finalViewModel.nextText(.text5n)
                }
            case .text5n:
                stageView {
                    finalViewModel.nextText(.text6n)
                }
            case .text6n:
                stageView {
                    finalViewModel.nextText(.text7n)
                }
            case .text7n:
                stageView {
                    finalViewModel.nextText(.text8n)
                }
            case .text8n:
                stageView {
                    finalViewModel.nextText(.text9n)
                }
            case .text9n:
                stageView {
                    finalViewModel.nextText(.text10n)
                }
            case .text10n:
                stageView {
                    finalViewModel.nextText(.text11n)
                }
            case .text11n:
                stageView {
                    finalViewModel.nextText(.text12n)
                }
            case .text12n:
                stageView {
                    finalViewModel.nextText(.text13n)
                }
            case .text13n:
                stageView {
                    finalViewModel.nextText(.text14n)
                }
            case .text14n:
                stageView {
                    finalViewModel.nextText(.text15n)
                }
            case .text15n:
                stageView {
                    finalViewModel.nextText(.text16n)
                }
            case .text16n:
                stageView {
                    finalViewModel.nextText(.text17n)
                }
            case .text17n:
                stageView {
                    finalViewModel.nextText(.text18n)
                }
            case .text18n:
                stageView {
                    finalViewModel.nextText(.text19n)
                }
            case .text19n:
                stageView {
                    finalViewModel.nextText(.text20n)
                }
            case .text20n:
                stageView {
                    finalViewModel.nextText(.text21n)
                }
            case .text21n:
                stageView {
                    finalViewModel.nextText(.text22n)
                }
            case .text22n:
                stageView {
                    finalViewModel.nextText(.text23n)
                }
            case .text23n:
                stageView {
                    finalViewModel.nextText(.text24n)
                }
            case .text24n:
                stageView {
                    finalViewModel.nextText(.text25n)
                }
            case .text25n:
                stageView {
                    finalViewModel.nextText(.text26n)
                }
            case .text26n:
                stageView {
                    finalViewModel.nextText(.text27n)
                }
            case .text27n:
                stageView {
                    finalViewModel.nextText(.text28n)
                }
            case .text28n:
                stageView {
                    finalViewModel.nextText(.text29n)
                }
            case .text29n:
                stageView {
                    if StorageManager.shared.gameKarma >= 50 {
                        finalViewModel.nextText(.textPR)
                    } else {
                        finalViewModel.nextText(.textNR)
                    }
                }
            case .textNR:
                finalStageView()
            case .textPR:
                finalStageView()
            }
        }
        .onAppear {
            finalViewModel.setBackImages(
                background: "back18",
                character: finalViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: finalViewModel.state) { _ in
            finalViewModel.setBackImages(
                background: "back18",
                character: finalViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(_ nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(finalViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(!finalViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(!finalViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            Task {
                try await writeTextSymbols()
            }
        }
    }
    
    @ViewBuilder private func stageViewWithAnswers(positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(finalViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(finalViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(!finalViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(!finalViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(finalViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(!finalViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(!finalViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                Task {
                    try await writeTextSymbols()
                }
                
            }
    }
    
    @ViewBuilder private func finalStageView() -> some View {
        VStack {
            Text(finalViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            
            Button(action: {
                currentStageState.route = .stage1
                StorageManager.shared.setStage1State(.preview)
                StorageManager.shared.setStage2State(.preview)
                StorageManager.shared.setStage3State(.preview)
                StorageManager.shared.setStage4State(.preview)
                StorageManager.shared.setStage5State(.preview)
                StorageManager.shared.setCurrentStage(.stage1)
                StorageManager.shared.resetKarma()
                StorageManager.shared.resetFirstGamePlayed()
                appRouter.push(route: .game)
            }, label: {
                Text("В главное меню")
                    .gameButtonStyle(.nextButton)
                    .opacity(!finalViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(!finalViewModel.printingFinished)
            .padding(.bottom)
            
            Button(action: {
                // MARK: - todo feedback
            }, label: {
                Text("Оценить наше творчество")
                    .gameButtonStyle(.nextButton)
                    .opacity(!finalViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(!finalViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            Task {
                try await writeTextSymbols()
            }
        }
    }
    
    func writeTextSymbols() async throws {
        for char in finalViewModel.phraseSource.text {
            finalViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        finalViewModel.printingFinished = true
    }
}
