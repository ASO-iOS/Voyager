//
//  Stage3Game4View.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

struct Stage3Game4View: View {
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @StateObject var stage3Game4ViewModel = Stage3Game4ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage3Game4ViewModel.state {
            case .text0:
                stageView {
                    stage3Game4ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage3Game4ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage3Game4ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage3Game4ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage3Game4ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage3Game4ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage3Game4ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage3Game4ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage3Game4ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage3Game4ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage3Game4ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage3Game4ViewModel.nextText(.game)
                }
            case .game:
                WheelComplicatedView() {
                    stage3ViewModel.setState(.freePlay)
                }
                .environmentObject(WheelComplicatedViewModel())
            }
            
        }
        .onAppear {
            stage3ViewModel.setBackImages(
                background: "back",
                character: stage3Game4ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage3Game4ViewModel.state) { _ in
            stage3ViewModel.setBackImages(
                background: "back",
                character: stage3Game4ViewModel.phraseSource.type.imageName
            )
        }
        
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game4ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game4ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game4ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage3Game4ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage3Game4ViewModel.phraseSource.text {
            stage3Game4ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: Constant.delay)
            }
        }
        stage3Game4ViewModel.printingFinished.toggle()
    }
    
}


