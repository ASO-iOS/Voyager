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
                LoteryView() {
                    stage1ViewModel.setState(.game3)
                }
                .environmentObject(LoteryViewModel())
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
    
    func writeTextBySymbols() async throws {
        for char in stage1Game2ViewModel.phraseSource.text {
            stage1Game2ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage1Game2ViewModel.printingFinished.toggle()
    }
    
}
