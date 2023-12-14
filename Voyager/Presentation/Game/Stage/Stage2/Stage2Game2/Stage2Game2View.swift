import SwiftUI

struct Stage2Game2View: View {
    
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    @StateObject var stage2Game2ViewModel = Stage2Game2ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage2Game2ViewModel.state {
            case .text0:
                stageView {
                    stage2Game2ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage2Game2ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage2Game2ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage2Game2ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage2Game2ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage2Game2ViewModel.nextText(.game)
                }
            case .game:
                DiceView() {
                    stage2ViewModel.setState(.game3)
                }
            }
            
            
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back",
                character: stage2Game2ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage2Game2ViewModel.state) { _ in
            stage2ViewModel.setBackImages(
                background: "back",
                character: stage2Game2ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage2Game2ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage2Game2ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage2Game2ViewModel.phraseSource.text {
            stage2Game2ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage2Game2ViewModel.printingFinished.toggle()
    }
    
}
