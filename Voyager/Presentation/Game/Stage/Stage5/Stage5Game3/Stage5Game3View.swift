import SwiftUI

struct Stage5Game3View: View {
    
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    @StateObject var stage5Game3ViewModel = Stage5Game3ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            
            switch stage5Game3ViewModel.state {
            case .text0:
                stageView {
                    stage5Game3ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage5Game3ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage5Game3ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage5Game3ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage5Game3ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage5Game3ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage5Game3ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage5Game3ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage5Game3ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage5Game3ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage5Game3ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage5Game3ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage5Game3ViewModel.nextText(.text13)
                }
            case .text13:
                stageView {
                    stage5Game3ViewModel.nextText(.text14)
                }
            case .text14:
                stageView {
                    stage5Game3ViewModel.nextText(.text15)
                }
            case .text15:
                stageView {
                    stage5Game3ViewModel.nextText(.text16)
                }
            case .text16:
                stageView {
                    stage5Game3ViewModel.nextText(.text17)
                }
            case .text17:
                stageView {
                    stage5Game3ViewModel.nextText(.text18)
                }
            case .text18:
                stageView {
//                    stage5Game3ViewModel.nextText(.game)
                    stage5ViewModel.setState(.game4)
                }
            case .game:
                stageView {
                    
                }
            }
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back",
                character: stage5Game3ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage5Game3ViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back",
                character: stage5Game3ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game3ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5Game3ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5Game3ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage5Game3ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage5Game3ViewModel.phraseSource.text {
            stage5Game3ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage5Game3ViewModel.printingFinished.toggle()
    }
    
}
