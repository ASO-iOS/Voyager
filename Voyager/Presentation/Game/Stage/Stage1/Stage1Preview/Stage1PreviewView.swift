//
//  Stage1PreviewView.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import SwiftUI

struct Stage1PreviewView: View {
    @StateObject var stage1PreviewViewModel = Stage1PreviewViewModel()
    @EnvironmentObject var stage1ViewModel: Stage1ViewModel
    @State var blur: CGFloat = 0
    
    var body: some View {
        ZStack {
            Group {
                VStack {
                    Text(stage1PreviewViewModel.textOutput)
                        .gameTextStyle(.textBack)
                        .padding(.bottom, 2)
                        .onTapGesture {
                            stage1ViewModel.skipText()
                        }
                    
                    Button(action: {
                        stage1ViewModel.setState(.game1)
                    }, label: {
                        Text("Дальше")
                            .padding(12)
                            .foregroundStyle(.white)
                            .opacity(stage1PreviewViewModel.printingFinished ? 0.3 : 1.0)
                            .font(.system(size: 18).monospaced().weight(.bold))
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .background(Color(.nextButton))
                            .border(Color.black, width: 2)
                    })
                    .disabled(stage1PreviewViewModel.printingFinished)
                    .padding(.bottom)
                    
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            }.onAppear {
                stage1ViewModel.setBackImages(
                    background: "back",
                    character: stage1PreviewViewModel.phraseSource.type.imageName
                )
                stage1PreviewViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
            }
        }
        .blur(radius: blur, opaque: false)
        .onAppear {
            withAnimation(.easeIn(duration: 1).repeatForever(autoreverses: true)) {
                blur = 1
            }
        }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage1PreviewViewModel.phraseSource.text {
            stage1PreviewViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: stage1ViewModel.delay)
            }
        }
        stage1PreviewViewModel.printingFinished.toggle()
        stage1ViewModel.resetDelay()
    }
}
