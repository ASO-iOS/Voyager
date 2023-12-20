import SwiftUI
//
struct Stage2PreviewView: View {
    
    @StateObject var stage2PreviewViewModel = Stage2PreviewViewModel()
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    
    var body: some View {
        ZStack {
            switch stage2PreviewViewModel.state {
            case .text0:
                stageView {
                    stage2PreviewViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage2PreviewViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage2PreviewViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage2PreviewViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage2PreviewViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage2PreviewViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage2PreviewViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage2PreviewViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage2PreviewViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage2PreviewViewModel.nextText(.text10)
                }
            case .text10:
                stageViewWithAnswers {
                    stage2ViewModel.setState(.game1)
                } negativeAction: {
                    stage2ViewModel.setState(.game1)
                }
                
            }
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back7",
                character: stage2PreviewViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage2PreviewViewModel.state) { _ in
            stage2ViewModel.setBackImages(
                background: "back7",
                character: stage2PreviewViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2PreviewViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2PreviewViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage2PreviewViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage2PreviewViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(src: String? = nil, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(src ?? stage2PreviewViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                //                nextState()
                //                stage1ViewModel.setState(.game1)
                positiveAction()
            }, label: {
                Text(stage2PreviewViewModel.phraseSource.answerPositive ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2PreviewViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage2PreviewViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                //                nextState()
                //                stage1ViewModel.setState(.game1)
                negativeAction()
            }, label: {
                Text(stage2PreviewViewModel.phraseSource.answerNegative ?? "")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2PreviewViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage2PreviewViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage2PreviewViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage2PreviewViewModel.phraseSource.text {
            stage2PreviewViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: UInt64(StorageManager.shared.textSpeed))
            }
        }
        stage2PreviewViewModel.printingFinished.toggle()
    }
    
}
