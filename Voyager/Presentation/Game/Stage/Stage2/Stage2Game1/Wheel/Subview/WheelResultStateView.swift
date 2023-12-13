//
//  WheelResultStateView.swift
//  Voyager
//
//  Created by admin on 12.12.2023.
//

import SwiftUI

struct WheelResultStateView: View {
    @EnvironmentObject var wheelViewModel: WheelViewModel
    var completion: () -> Void = {}
    var body: some View {
        VStack {
            Text("\(wheelViewModel.resultGameRWData.num), \(wheelViewModel.resultGameRWData.color.colorName)")
                .gameButtonStyle(.textBack)
                .padding(.bottom)
            Text(resultVisual())
                .gameButtonStyle(.textBack)
                .padding(.bottom, 64)
            Button(action: {
                wheelViewModel.resetGame()
            }, label: {
                Text("Еще разок?")
                    .gameButtonStyle(.nextButton)
            })
            Button(action: {
                completion()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
            })
            .padding(.bottom, 45)
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .miniGameBackground()
    }
    
    private func resultVisual() -> String {
        if wheelViewModel.resultAmount > 0 {
            return "+\(wheelViewModel.resultAmount)"
        } else {
            return "\(wheelViewModel.resultAmount)"
        }
    }
}
