//
//  InvestmentView.swift
//  MinigamesMZ
//
//  Created by mnats on 22.11.2023.
//

import SwiftUI

struct InvestmentView: View {
    @ObservedObject var viewModel: InvestmentViewModel
    @State var runningView: RunningLineView
    
    
    var completion: () -> Void = {}
    
    init(completion: @escaping () -> Void = {}) {
        self.viewModel = InvestmentViewModel()
        let array = ["Gazik", "Sberz", "Lukol", "Yandx", "Rosny", "Aerok", "Rostl", "VKut", "Magny", "Kaspk", "Belug", "AlfaZ", "X5ail", "Mobil", "Trans", "Noril", "Vebro", "Tatnf", "Evraz", "Sevrl"]
        self.runningView = RunningLineView(items: array)
        self.completion = completion
    }
    
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
//        ZStack {
            VStack {
                Spacer()
                runningView
                    .frame(height: 100)
                HStack {
                    LineChartView(data: viewModel.chartData,
                                  minY: viewModel.minY,
                                  maxY: viewModel.maxY,
                                  color: $viewModel.chartColor)
                    .frame(height: 200)
                    .foregroundStyle(.red)
                    .background(
                        RoundedRectangle(cornerRadius: 10).foregroundStyle(viewModel.chartColor.opacity(0.4))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .gameButtonStyle(Color(white: 0.8))
                }
                .padding()
                
                Image("keyboard")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                
                VStack {
//                    Spacer()
                    if !viewModel.isFinishPresented {
                        Text("Инвестировать")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            ForEach([100, 250, 500], id: \.self) { amount in
                                Button(action: {
                                    viewModel.bet = amount
                                    Task {
                                        await viewModel.play()
                                    }
                                }, label: {
                                    Text(amount.description)
                                        .gameButtonStyle( .nextButton)
                                })
                            }
                        }
                        .disabled(viewModel.buttonDisabled)
                        .opacity(viewModel.buttonDisabled ? 0.5 : 1)
                        
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
            }
            .frame(maxWidth: .infinity)
            .miniGameBackground()
    }
}
