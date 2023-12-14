//
//  Stage1Game1View.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import SwiftUI

struct Stage3Game1View: View {
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @StateObject var stage3Game1ViewModel = Stage3Game1ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage3Game1ViewModel.state {
            case .text0:
                stageView {
                    stage3Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage3Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage3Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage3Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage3Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage3Game1ViewModel.nextText(.game)
                }
            case .game:
                MexicoHippodromView() {
                    stage3ViewModel.setState(.game2)
                } .environmentObject(MexicoHippodromViewModel())
            }
            
        }
        .onAppear {
            stage3ViewModel.setBackImages(
                background: "back",
                character: stage3Game1ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage3Game1ViewModel.state) { _ in
            stage3ViewModel.setBackImages(
                background: "back",
                character: stage3Game1ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game1ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game1ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game1ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage3Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage3Game1ViewModel.phraseSource.text {
            stage3Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage3Game1ViewModel.printingFinished.toggle()
    }
    
}

