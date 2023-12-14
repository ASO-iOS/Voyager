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
//                    stage5Game1ViewModel.nextText(.game)
                    stage5ViewModel.setState(.game2)
                }
            case .game:
                stageView {
                    
                }
            }
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back",
                character: stage5Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage5Game1ViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back",
                character: stage5Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
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
    
    func writeTextBySymbols() async throws {
        for char in stage5Game1ViewModel.phraseSource.text {
            stage5Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage5Game1ViewModel.printingFinished.toggle()
    }
    
    
}
