//
//  CharityView.swift
//  Voyager
//
//  Created by admin on 14.12.2023.
//

import SwiftUI

struct CharityView: View {
    @StateObject var charityViewModel = CharityViewModel()
    var completion: () -> Void
    
    var body: some View {
        ZStack {
            switch charityViewModel.state {
            case .selectShesterka:
                CharitySelectShesterkaView()
            case .selectAmount:
                CharitySelectAmountView()
            case .loading:
                CharityLoadingView()
            case .result:
                CharityResultView {
                    completion()
                }
            }
        }
        .environmentObject(charityViewModel)
    }
}
