//
//  ShellGameView.swift
//  dices
//
//  Created by mnats on 20.11.2023.
//

//MARK: - UPDATE


import SwiftUI

struct ShellGameView: View {
    @EnvironmentObject var viewModel: ShellGameViewModel
    //MARK: - cupsCount = 1, winChance = 0 при плохой карме
    @State var reveal: Bool = false
    @State var shuffleInProgress = false
    var completion: () -> Void
    var finishCompletion: (Int) -> Void = {_ in }
    
    func play() {
        shuffleInProgress = true
        viewModel.setUpCups(reveal: $reveal)
        Task {
            await shuffle(times: 5, speed: 3)
            try? await Task.sleep(nanoseconds: 400_000_000)
            reveal.toggle()
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await shuffle()
            viewModel.readyToReveal = true
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation {
                shuffleInProgress = false
            }
        }
    }
    
    func shuffle(times: Int = 10, speed: Float = 1) async {
        var counter = times
        while counter > 0 {
            withAnimation {
                viewModel.shuffleCups()
            }
            try? await Task.sleep(nanoseconds: UInt64(300_000_000 / speed))
            counter -= 1
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                if viewModel.readyToReveal {
                    Text("Где шарик??? =)))")
                }
                if viewModel.isFinish {
                    if viewModel.isWin {
                        Text("+\(viewModel.bet)")
                        
                    } else {
                        Text("-\(viewModel.bet)")
                    }
                }
            }
            .onChange(of: viewModel.isFinish, perform: { value in
                if value {
                    finishCompletion(viewModel.bet)
//                    DispatchQueue.main.async {
//                        balanceManager.changeBalance(amount: viewModel.bet)
//                    }
                    
                }
            })
            .gameButtonStyle(.textBack)
            .zIndex(20)
            VStack {
                HStack {
                    ForEach(viewModel.cupViews, id: \.id) { cupView in
                        cupView
                        
                            .disabled(!viewModel.readyToReveal)
                            .minimumScaleFactor(0.1)
                            .frame(maxWidth: 150)
                        
                    }
                }
                .padding()
                
                if !viewModel.isFinish {
                    VStack {
                        Text("Поставить")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            ForEach([100, 250, 500], id: \.self) { amount in
                                Button(action: {
                                    
                                    viewModel.bet = amount
                                    play()
                                }, label: {
                                    Text(amount.description)
                                        .gameButtonStyle( .nextButton)
                                })
                            }
                        }
                        .padding(.bottom, 6)
                    }
                    .disabled(shuffleInProgress || viewModel.readyToReveal)
                    .opacity(shuffleInProgress || viewModel.readyToReveal ? 0 : 1)
                } else {
                    VStack {
                        Text("Поставить еще?")
                            .gameButtonStyle(.textBack)
                        
                        VStack {
                            Text("empty")
                                .gameButtonStyle(.clear)
                                .opacity(0)
                            Button(action: {
                                viewModel.setUpCups(reveal: $reveal)
                                viewModel.isFinish = false
                                viewModel.readyToReveal = false
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
                    .padding(.bottom, 6)
                }
            }
        }
        
        .onAppear {
            viewModel.setUpCups(reveal: $reveal)
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
}
