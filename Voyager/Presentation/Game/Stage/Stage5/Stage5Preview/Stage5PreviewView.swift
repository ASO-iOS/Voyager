import SwiftUI

struct Stage5PreviewView: View {
    
    @StateObject var stage5PreviewViewModel = Stage5PreviewViewModel()
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    
    var body: some View {
        ZStack {
            
            switch stage5PreviewViewModel.state {
            case .text0:
                stageView {
                    stage5PreviewViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage5PreviewViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage5PreviewViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage5PreviewViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage5PreviewViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage5PreviewViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage5PreviewViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage5PreviewViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage5PreviewViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage5ViewModel.setState(.game1)
                }
            }
            
        }
        .onAppear {
            stage5ViewModel.setBackImages(
                background: "back17",
                character: stage5PreviewViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage5PreviewViewModel.state) { _ in
            stage5ViewModel.setBackImages(
                background: "back17",
                character: stage5PreviewViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5PreviewViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage5PreviewViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage5PreviewViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage5PreviewViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage5PreviewViewModel.phraseSource.text {
            stage5PreviewViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage5PreviewViewModel.printingFinished.toggle()
    }
}
