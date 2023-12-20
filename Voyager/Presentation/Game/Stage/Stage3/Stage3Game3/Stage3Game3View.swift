//
//  Stage3Game3View.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

import SwiftUI

struct Stage3Game3View: View {
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @StateObject var stage3Game3ViewModel = Stage3Game3ViewModel()
//    @EnvironmentObject var appController: ApplicationController
    var body: some View {
        ZStack {
            switch stage3Game3ViewModel.state {
            case .text0:
                stageView {
                    stage3Game3ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage3Game3ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage3Game3ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage3Game3ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage3Game3ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage3Game3ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage3Game3ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage3Game3ViewModel.nextText(.game)
                }
            case .game:
                UpdetedSportBettingView() {
                    stage3ViewModel.setState(.game4)
                }.environmentObject(UpdetedSportBettingViewModel())
            }
            
        }
        .onAppear {
            stage3ViewModel.setBackImages(
                background: "back8",
                character: stage3Game3ViewModel.phraseSource.type.imageName
            )
        }
        .onChange(of: stage3Game3ViewModel.state) { _ in
            stage3ViewModel.setBackImages(
                background: "back0",
                character: stage3Game3ViewModel.phraseSource.type.imageName
            )
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game3ViewModel.textOutput)
                .gameTextStyle(.textBack)
                .padding(.bottom, 2)
                .onTapGesture {
                    stage3ViewModel.skipText()
                }
            
            Button(action: {
                nextState()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
                    .opacity(stage3Game3ViewModel.printingFinished ? 0.3 : 1.0)
            })
            .disabled(stage3Game3ViewModel.printingFinished)
            .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
                stage3Game3ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage3Game3ViewModel.phraseSource.text {
            stage3Game3ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: stage3ViewModel.delay)
            }
        }
        stage3Game3ViewModel.printingFinished.toggle()
        stage3ViewModel.resetDelay()
    }
    
}


