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
                //                stageView {
                //                    stage2ViewModel.setState(.game1)
                //                }
                stageViewWithAnswers {
                    stage2ViewModel.setState(.game1)
                } negativeAction: {
                    stage2ViewModel.setState(.game4)
                }
                
            }
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back",
                character: stage2PreviewViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2PreviewViewModel.textOutput)
                .padding(12)
                .foregroundStyle(.white)
                .font(.system(size: 14).monospaced().weight(.bold))
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(Color(.textBack))
                .border(Color.black, width: 2)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage2PreviewViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
//            .disabled(stage2PreviewViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
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
                .padding(12)
                .foregroundStyle(.white)
                .font(.system(size: 14).monospaced().weight(.bold))
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(Color(.textBack))
                .border(Color.black, width: 2)
                .padding(.bottom, 2)
            
            Button(action: {
                //                nextState()
                //                stage1ViewModel.setState(.game1)
                positiveAction()
            }, label: {
                Text(stage2PreviewViewModel.phraseSource.answerPositive ?? "")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage2PreviewViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage2PreviewViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                //                nextState()
                //                stage1ViewModel.setState(.game1)
                negativeAction()
            }, label: {
                Text(stage2PreviewViewModel.phraseSource.answerNegative ?? "")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage2PreviewViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage2PreviewViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
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
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage2PreviewViewModel.printingFinished.toggle()
    }
    
}