import SwiftUI

struct Stage2Game3View: View {
    
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    @StateObject var stage2Game3ViewModel = Stage2Game3ViewModel()
    
    var body: some View {
        ZStack {
            switch stage2Game3ViewModel.state {
            case .text0:
                stageView {
                    stage2Game3ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage2Game3ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage2Game3ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage2Game3ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage2Game3ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage2Game3ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage2Game3ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage2Game3ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage2Game3ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage2Game3ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage2Game3ViewModel.nextText(.game)
                }
            case .game:
                ShellGameView(completion: {
                    stage2ViewModel.setState(.game4)
                })
                    .environmentObject(ShellGameViewModel(cupsCount: 5, winChance: 0.3))
            }
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back12",
                character: stage2Game3ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage2Game3ViewModel.state) { _ in
            stage2ViewModel.setBackImages(
                background: "back11",
                character: stage2Game3ViewModel.phraseSource.type.imageName
            )
        }
        
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2Game3ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2Game3ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage2Game3ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage2Game3ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage2Game3ViewModel.phraseSource.text {
            stage2Game3ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage2Game3ViewModel.printingFinished.toggle()
    }
}
    
