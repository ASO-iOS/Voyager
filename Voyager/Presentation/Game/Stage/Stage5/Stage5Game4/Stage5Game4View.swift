import SwiftUI

struct Stage5Game4View: View {
    
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    @StateObject var stage5Game4ViewModel = Stage5Game4ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            
            switch stage5Game4ViewModel.state {
            case .text0:
                stageView {
                    stage5Game4ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage5Game4ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage5Game4ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage5Game4ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage5Game4ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage5Game4ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage5Game4ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage5Game4ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage5Game4ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage5Game4ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage5Game4ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage5Game4ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage5Game4ViewModel.nextText(.text13)
                }
            case .text13:
                stageView {
                    stage5Game4ViewModel.nextText(.text14)
                }
            case .text14:
                stageView {
                    stage5Game4ViewModel.nextText(.text15)
                }
            case .text15:
                stageView {
                    stage5Game4ViewModel.nextText(.text16)
                }
            case .text16:
                stageView {
                    stage5Game4ViewModel.nextText(.text17)
                }
            case .text17:
                stageView {
                    stage5Game4ViewModel.nextText(.text18)
                }
            case .text18:
                stageView {
                    stage5Game4ViewModel.nextText(.text19)
                }
            case .text19:
                stageView {
                    stage5Game4ViewModel.nextText(.text20)
                }
            case .text20:
                stageView {
                    stage5Game4ViewModel.nextText(.text21)
                }
            case .text21:
                stageView {
                    stage5Game4ViewModel.nextText(.game)
                }
            case .game:
                StocksView() {
                    stage5ViewModel.setState(.freePlay)
                }
            }
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back11",
                character: stage5Game4ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage5Game4ViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back11",
                character: stage5Game4ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game4ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5Game4ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5Game4ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage5Game4ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage5Game4ViewModel.phraseSource.text {
            stage5Game4ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage5Game4ViewModel.printingFinished.toggle()
    }
    
}
