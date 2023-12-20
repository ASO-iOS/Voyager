//
//  Stage3Game2View.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

struct Stage3Game2View: View {
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @StateObject var stage3Game2ViewModel = Stage3Game2ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage3Game2ViewModel.state {
            case .text0:
                stageView {
                    stage3Game2ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage3Game2ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage3Game2ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage3Game2ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage3Game2ViewModel.nextText(.game)
//                    stage3ViewModel.setState(.game3)
                }
            case .game:
                TwentyOneView() {
                    stage3ViewModel.setState(.game3)
                }
            }
            
        }
        .onAppear {
            stage3ViewModel.setBackImages(
                background: "back8",
                character: stage3Game2ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage3Game2ViewModel.state) { _ in
            stage3ViewModel.setBackImages(
                background: "back8",
                character: stage3Game2ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game2ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage3ViewModel.skipText()
                }
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game2ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game2ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage3Game2ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage3Game2ViewModel.phraseSource.text {
            stage3Game2ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: stage3ViewModel.delay)
            }
        }
        stage3Game2ViewModel.printingFinished.toggle()
        stage3ViewModel.resetDelay()
    }
    
}

