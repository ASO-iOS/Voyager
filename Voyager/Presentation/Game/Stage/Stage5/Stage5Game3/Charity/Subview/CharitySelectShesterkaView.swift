//
//  CharitySelectShesterkaView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import SwiftUI

struct CharitySelectShesterkaView: View {
    @EnvironmentObject var charityViewModel: CharityViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("Кому поможем?")
                .gameButtonStyle(.textBack)
            ForEach(charityViewModel.currentArray, id: \.id) { charity in
                Button(action: {
                    charityViewModel.currentCharity = charity
                    charityViewModel.setState(.selectAmount)
                }, label: {
                    Text(charity.name)
                        .gameButtonStyle(.nextButton)
                })
            }
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
}
