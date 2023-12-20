//
//  CharitySelectAmountView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import SwiftUI

struct CharitySelectAmountView: View {
    @EnvironmentObject var charityViewModel: CharityViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("Сколько вложим?")
                .gameButtonStyle(.textBack)
            ForEach(charityViewModel.amountArray, id: \.self) { amount in
                Button(action: {
                    charityViewModel.amount = amount
                    charityViewModel.calculate()
                    charityViewModel.setState(.loading)
                }, label: {
                    Text("\(amount)")
                        .gameButtonStyle(.nextButton)
                })
            }
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
}
