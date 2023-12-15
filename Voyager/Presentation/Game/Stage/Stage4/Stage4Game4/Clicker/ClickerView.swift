//
//  ClickerView.swift
//  MinigamesMZ
//
//  Created by mnats on 29.11.2023.
//

import SwiftUI

struct ClickerView: View {
    @StateObject var viewModel = ClickerViewModel()
    
    var completion = {}
    
    private func getLabel() -> String {
        if viewModel.gameResult == .win {
            return "+\(viewModel.bet)"
        } else if viewModel.gameResult == .lose {
            return "-\(viewModel.bet)"
        } else {
            return "Попробуем еще?"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            if viewModel.timer?.isValid == nil {
                    VStack {
                        Text("Поставить")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            ForEach([100, 250, 500], id: \.self) { amount in
                                Button(action: {
                                    viewModel.bet = amount
                                    viewModel.startTimer()
                                }, label: {
                                    Text(amount.description)
                                        .gameButtonStyle( .nextButton)
                                })
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .miniGameBackground()
                } else if !viewModel.isFinishPresented {
                    VStack {
                        Text(viewModel.label)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .gameButtonStyle(.textBack)
                        ZStack {
                            VStack(spacing: 0) {
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .gameButtonStyle(.green)
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .gameButtonStyle(.red)
                            }
                            .frame(width: 300, height: 300)
                            .overlay {
                                Image(systemName: "arrow.up")
                                    .gameButtonStyle(.nextButton, width: 40)
                                    .frame(height: 40)
                                    .offset(y: viewModel.offsetY)
                            }
                            .onTapGesture {
                                viewModel.onTapGesture()
                            }
                            .padding()
                        }
                        .onChange(of: viewModel.offsetY) { _ in
                            viewModel.checkOffset()
                        }
                        Text("Стучи по экрану как умалишенный!")
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .gameButtonStyle(.textBack)
//                        Button("Start") {
//                            viewModel.startTimer()
//                        }
                    }
                    .frame(maxWidth: .infinity)
                    .miniGameBackground(height: 0.6)
                } else {
                    VStack {
                        Text(getLabel())
                            .gameButtonStyle(.textBack)
                        Text("Поставить еще?")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            Button(action: {
                                viewModel.reset()
                            }, label: {
                                Text("Да")
                                    .gameButtonStyle( .nextButton)
                            })
                            Button(action: {
                                completion()
                            }, label: {
                                Text("Нет")
                                    .gameButtonStyle( .nextButton)
                            })
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .miniGameBackground()
                }
        }
        .padding(.bottom, 6)
    }
}

//#Preview {
//    ClickerView()
//}
