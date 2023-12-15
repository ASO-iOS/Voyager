//
//  ContentView.swift
//  dices
//
//  Created by mnats on 20.11.2023.
//

//MARK: - UPDATE

import SwiftUI

struct DiceView: View {
    @ObservedObject var viewModel: DiceViewViewModel = DiceViewViewModel(diceAmount: 2)
    @State var rotatingFaceName: String = "dice1"
    
    var completion: () -> Void = {}
    
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
            if viewModel.bet == 0 {
                VStack {
                    Spacer()
                    Text("Поставить")
                        .gameButtonStyle(.textBack)
                    
                    VStack {
                        ForEach([100, 250, 500], id: \.self) { amount in
                            Button(action: {
                                viewModel.bet = amount
                                viewModel.rollDice()
                            }, label: {
                                Text(amount.description)
                                    .gameButtonStyle( .nextButton)
                            })
                        }
                    }
                    .padding(.bottom, 24)
                }
            } else {
                Spacer()
                if viewModel.isFinishPresented {
                    VStack {
                        Text("Поставить еще?")
                            .gameButtonStyle(.textBack)
                        ForEach([100, 250, 500], id: \.self) { amount in
                            Button(action: {
                                viewModel.resetGame()
                                viewModel.bet = amount
                                viewModel.rollDice()
                            }, label: {
                                Text(amount.description)
                                    .gameButtonStyle(.nextButton)
                            })
                        }
                        Button(action: {
                            completion()
                        }, label: {
                            Text("Нет")
                        })
                        .gameButtonStyle(.nextButton)
                    }
                    .padding(.bottom, 6)
                } else {
                    VStack {
                        if viewModel.diceRotating == false {
                            Text(getLabel())
                                .gameButtonStyle(.textBack)
                        }
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                ForEach(viewModel.enemyFaces, id: \.self) { face in
                                    Image(viewModel.diceRotating ? rotatingFaceName : face)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120)
                                        .rotationEffect(.degrees(viewModel.diceRotation * CGFloat.random(in: 0.8...1.2)))
                                        .padding(5)
                                }
                            }
                            HStack(spacing: 0) {
                                ForEach(viewModel.playerFaces, id: \.self) { face in
                                    Image(viewModel.diceRotating ? rotatingFaceName : face)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120)
                                        .rotationEffect(.degrees(viewModel.diceRotation * CGFloat.random(in: 0.95...1.05)))
                                        .padding(5)
                                        .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
}
