import SwiftUI


struct Stage5Game2View: View {
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    @StateObject var stage5Game2ViewModel = Stage5Game2ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage5Game2ViewModel.state {
            case .text0:
                stageView {
                    stage5Game2ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage5Game2ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage5Game2ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage5Game2ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage5Game2ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage5Game2ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage5Game2ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage5Game2ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage5Game2ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage5Game2ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage5Game2ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage5Game2ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage5Game2ViewModel.nextText(.game)
//                    stage5ViewModel.setState(.game3)
                }
            case .game:
                CryptoView() {
                    stage5ViewModel.setState(.game3)
                }
            }
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back",
                character: stage5Game2ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage5Game2ViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back",
                character: stage5Game2ViewModel.phraseSource.type.imageName
            )
        }
    }
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5Game2ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            stage5Game2ViewModel.printingFinished.toggle()
            Task {
                try await writeTextBySymbols()
            }
            
        }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage5Game2ViewModel.phraseSource.text {
            stage5Game2ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage5Game2ViewModel.printingFinished.toggle()
    }
    
    
}
