//
//  CryptoView.swift
//  MinigamesMZ
//
//  Created by mnats on 23.11.2023.
//

import SwiftUI

struct CryptoView: View {
    @ObservedObject var viewModel = CryptoViewModel(numberOfCharts: 3)
    @State var runningView: RunningLineView
    
    var completion: () -> Void = {}
    
    init(numberOfCharts: Int = 3, completion: @escaping () -> Void = {}) {
        self.viewModel = CryptoViewModel(numberOfCharts: numberOfCharts)
        let array = ["BitBuck", "CoinCon", "EtherYm", "RipRap", "LiteLot", "DashDsh", "DogeDbl", "Linky", "MoneroM", "StelarS", "Cardano", "PolkaDz", "TethrTl", "BinBuck", "Uniswop", "VeChnVt", "TronTrk", "Cosmos", "TezosT", "NeoNug"]
        self.runningView = RunningLineView(items: array)
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
                runningView.frame(height: 100)
                HStack {
                    ZStack {
                        ForEach(0..<viewModel.numberOfCharts, id: \.self) { index in
                            LineChartView(data: viewModel.chartDatas[index],
                                          minY: viewModel.minY,
                                          maxY: viewModel.maxY,
                                          color: $viewModel.chartColors[index])
                        }
                    }
                    .frame(height: 200)
                    .foregroundStyle(.red)
                    .background(
                        RoundedRectangle(cornerRadius: 10).foregroundStyle(viewModel.chartColors[0].opacity(0.2))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .gameButtonStyle(Color(white: 0.8))
                }
                .padding()
                
                Image("keyboard")
                    .resizable()
                    .scaledToFit()
                
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
//                        Spacer()
                        Text("Инвестировать еще?")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            Button(action: {
                                viewModel.restart()
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
            
//        }
    }
}

//
//#Preview {
//    CryptoView()
//}
