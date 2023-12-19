//
//  OptionView.swift
//  MinigamesMZ
//
//  Created by mnats on 24.11.2023.
//

import SwiftUI

struct OptionView: View {
    @ObservedObject private var viewModel = OptionViewModel()
    
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
        ZStack {
            VStack {
                Spacer()
                
                ZStack {
                    VStack(spacing: 0) {
                        Color.green.frame(height: 75)
                        Color.red.frame(height: 75)
                    }
                    .frame(width: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Rectangle()
                        .frame(width: 20, height: 5)
                        .offset(y: -viewModel.sliderValue * 150)
                }
                .background {
                    SmartPhoneView(size: 150, background: {
                        Image("back")
                            .resizable()
                    })
                }
                .padding(.bottom, 150)
                
                
                VStack {
                    if !viewModel.isFinishPresented {
                        if viewModel.bet == 0 {
                            Text("Инвестировать")
                                .gameButtonStyle(.textBack)
                            
                            VStack {
                                ForEach([100, 250, 500], id: \.self) { amount in
                                    Button(action: {
                                        viewModel.bet = amount
                                    }, label: {
                                        Text(amount.description)
                                            .gameButtonStyle( .nextButton)
                                    })
                                }
                            }
                            .disabled(viewModel.buttonDisabled)
                            .opacity(viewModel.buttonDisabled ? 0.5 : 1)
                        } else {
                            Text("Вырастет или упадет?")
                                .gameButtonStyle(.textBack)
                            Text("Вырастет или упадет?")
                                .gameButtonStyle(.textBack)
                                .opacity(0)
                            Button {
                                viewModel.selectedDirection = .up
                                viewModel.startAnimating()
                            } label: {
                                Text("Вырастет")
                                    .gameButtonStyle(.nextButton)
                            }
                            
                            Button {
                                viewModel.selectedDirection = .down
                                viewModel.startAnimating()
                            } label: {
                                Text("Упадет")
                                    .gameButtonStyle(.nextButton)
                            }
                        }
                        
                    } else {
                        Text(getLabel())
                            .gameButtonStyle(.textBack)
                        Text("Инвестировать еще?")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            Button(action: {
                                viewModel.isFinishPresented = false
                                viewModel.buttonDisabled = false
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
                }
                .padding(.bottom, 6)
                .frame(maxWidth: .infinity)
                .miniGameBackground()
            }
        }
    }
}

#Preview {
    OptionView()
}
