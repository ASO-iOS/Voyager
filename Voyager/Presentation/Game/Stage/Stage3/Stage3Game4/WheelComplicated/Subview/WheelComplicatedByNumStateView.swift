//
//  WheelComplicatedByNumStateView.swift
//  Voyager
//
//  Created by admin on 13.12.2023.
//

import SwiftUI

struct WheelComplicatedByNumStateView: View {
    @EnvironmentObject var wheelViewModel: WheelComplicatedViewModel
    @State var mNum = Int.random(in: 0...36)
    var body: some View {
        VStack {
        Text("На что ставишь?")
            .gameButtonStyle(.textBack)
        VStack {
            HStack {
                Button(action: {
                    if mNum > 0 {
                        mNum -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 15, height: 20)
                        .foregroundStyle(.white)
                        .gameButtonStyle(.nextButton, width: UIScreen.main.bounds.width * 0.2)
                })
                Text("\(mNum)")
                    .gameButtonStyle(.nextButton, width: UIScreen.main.bounds.width * 0.45)
                
                Button(action: {
                    if mNum < 36 {
                        mNum += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 15, height: 20)
                        .foregroundStyle(.white)
                        .gameButtonStyle(.nextButton, width: UIScreen.main.bounds.width * 0.2)
                })
            }
            Button(action: {
                wheelViewModel.setGameScene(selectType: .byNum, num: mNum)
            }, label: {
                Text("Крутануть")
                    .gameButtonStyle(.nextButton)
            })
        }
        .padding(.bottom, 64)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .miniGameBackground()
    }
}

