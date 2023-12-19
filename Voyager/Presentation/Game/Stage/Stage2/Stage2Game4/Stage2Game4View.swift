import SwiftUI

struct Stage2Game4View: View {
    
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    @StateObject var stage2Game4ViewModel = Stage2Gam4ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage2Game4ViewModel.state {
            case .text0:
                stageView {
                    stage2Game4ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage2Game4ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage2Game4ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage2Game4ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage2Game4ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage2Game4ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage2Game4ViewModel.nextText(.game)
                }

            case .game:

                OriginalSportBettingView() {
                    stage2ViewModel.setState(.freePlay)
                }.environmentObject(OriginalSportBettingViewModel())
                    
            }
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back",
                character: stage2Game4ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage2Game4ViewModel.state) { _ in
            stage2ViewModel.setBackImages(
                background: "back",
                character: stage2Game4ViewModel.phraseSource.type.imageName
            )
        }
        
        
    }
        
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2Game4ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2Game4ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage2Game4ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage2Game4ViewModel.phraseSource.text {
            stage2Game4ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage2Game4ViewModel.printingFinished.toggle()
    }
    
}
