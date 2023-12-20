//
//  SlotMashineView.swift
//  SPR
//
//  Created by admin on 11/21/23.
//

import SwiftUI

struct SlotMashineView: View {
    
//    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @ObservedObject var slotMashineViewModel: SlotMashineViewModel
    var completion: () -> Void = {}
    var depositArray: [Int]
    
    init(depositArray: [Int], betAmount: Int, completion: @escaping () -> Void) {
        self.slotMashineViewModel = SlotMashineViewModel(betAmount: betAmount)
        self.completion = completion
        self.depositArray = depositArray
    }

    
    var body: some View {
            
            VStack {
                switch slotMashineViewModel._gameStatus {
                case .chooseDepositSize:
                    chooseDepositeView()
                case .playing:
                    playingView()
                case .result:
                    resultView()
                }
            }
        
        
    }
    
    
    
    @ViewBuilder private func chooseDepositeView() -> some View {
        VStack {
            
            Spacer()
            
            Text("Сколько ставим-с?")
                .gameButtonStyle(.textBack)
            ForEach(depositArray, id: \.self) { deposit in
                chooseDepositeSizeButton(deposit)
            }
                
        }
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
    
    @ViewBuilder private func chooseDepositeSizeButton(_ size: Int) -> some View {
        Button(action: {
            BalanceManager.shared.changeBalance(by: size, gameResult: .lose)
            slotMashineViewModel.depositeSize = size
            slotMashineViewModel.maxDepositeSize = size * 3
            slotMashineViewModel.setPlaying()
        }, label: {
        Text("\(size)")
                .gameButtonStyle(.nextButton)
        })
    }
    
    
    @ViewBuilder private func imageSpinRowView(_ a: Int, _ b: Int, _ c: Int) -> some View {
        HStack {
            Spacer()
            
            Image(slotMashineViewModel.symbols[slotMashineViewModel.numbers[a]])
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .frame(width: 100, height: 100)
            
            Image(slotMashineViewModel.symbols[slotMashineViewModel.numbers[b]])
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .frame(width: 100, height: 100)
            
            Image(slotMashineViewModel.symbols[slotMashineViewModel.numbers[c]])
                .resizable()
                .aspectRatio(1, contentMode: .fit )
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .frame(width: 100, height: 100)
            Spacer()
        }
    }
    
    
    
    @ViewBuilder private func playingView() -> some View {
        VStack {
            
            Spacer()
            Text("\(slotMashineViewModel.depositeSize)")
                .gameButtonStyle(slotMashineViewModel.depositeBackColor)
                .padding(.bottom, 32)
            
            VStack {
                imageSpinRowView(0, 1, 2)
                imageSpinRowView(3, 4, 5)
                imageSpinRowView(6, 7, 8)
                
                
            }
            .padding(.bottom, 40)
            
            Button(action: {
                slotMashineViewModel.startSlotAnimation()
            }, label: {
                Text("Крутим!!")
                    .gameButtonStyle(.nextButton)
            })
            .disabled(slotMashineViewModel.isPlaying)
            .opacity(slotMashineViewModel.isPlaying ? 0.3 : 1.0)
            
            Button(action: {
                BalanceManager.shared.changeBalance(by: slotMashineViewModel.depositeSize, gameResult: .win)
                slotMashineViewModel.setResult()
            }, label: {
                Text("Хватит!")
                    .gameButtonStyle(.nextButton)
            })
            
            
        }
        .padding(.bottom)
        
    }

    
    @ViewBuilder private func resultView() -> some View {
        VStack {
            
            Spacer()
            Text("\(slotMashineViewModel.depositeSize)")
                .gameButtonStyle(slotMashineViewModel.depositeBackColor)
                .padding(.bottom)
//            Spacer()
            
            Text("Закончили упражнение.")
                .gameButtonStyle(.textBack)
            
            Button(action: {
                slotMashineViewModel.setChooseDepositteSize()
            }, label: {
                Text("Может ещё покрутим?")
                    .gameButtonStyle(.nextButton)
            })
            
            
            Button(action: {
                completion()
//                stage4ViewModel.setState(.game4)
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
            }) .padding(.bottom, 32)
            
            
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
}
