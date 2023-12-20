import SwiftUI

struct Stage2Game1View: View {
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    @StateObject var stage2Game1ViewModel = Stage2Game1ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            switch stage2Game1ViewModel.state {
            case .text0:
                stageView {
                    stage2Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage2Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage2Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage2Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage2Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage2Game1ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage2Game1ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage2Game1ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage2Game1ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage2Game1ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage2Game1ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage2Game1ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage2Game1ViewModel.nextText(.text13)
                }
            case .text13:
                stageView {
                    stage2Game1ViewModel.nextText(.text14)
                }
            case .text14:
                stageView {
                    stage2Game1ViewModel.nextText(.text15)
                }
            case .text15:
                stageView {
                    stage2Game1ViewModel.nextText(.text16)
                }
            case .text16:
                stageView {
                    stage2Game1ViewModel.nextText(.text17)
                }
            case .text17:
                stageView {
                    stage2Game1ViewModel.nextText(.text18)
                }
            case .text18:
                stageView {
                    stage2Game1ViewModel.nextText(.text19)
                }
            case .text19:
                stageView {
                    stage2Game1ViewModel.nextText(.game)
                }
            case .game:
                WheelView() {
                    
                        stage2ViewModel.setState(.game2)
                }
                    .environmentObject(WheelViewModel())
            }
        }
        .onAppear {
            stage2ViewModel.setBackImages(
                background: "back7",
                character: stage2Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage2Game1ViewModel.state) { _ in
            stage2ViewModel.setBackImages(
                background: "back1",
                character: stage2Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage2ViewModel.skipText()
                }
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage2Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage2Game1ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage2Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage2Game1ViewModel.phraseSource.text {
            stage2Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: stage2ViewModel.delay)
            }
        }
        stage2Game1ViewModel.printingFinished.toggle()
        stage2ViewModel.resetDelay()
    }
    
}
