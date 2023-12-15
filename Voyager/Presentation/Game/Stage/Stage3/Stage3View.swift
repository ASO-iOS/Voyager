//
//  Stage3View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage3View: View {
    @EnvironmentObject var stageViewModel: Stage3ViewModel
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
//    @EnvironmentObject var appController: ApplicationController
    
    var body: some View {
        ZStack {
            Image(stageViewModel.background)
                .resizable()
                .ignoresSafeArea(.all)
            if !stageViewModel.character.isEmpty {
                Image(stageViewModel.character)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
            }
            VStack {
                HStack {
                    Button(action: {
                        appRouter.pop()
                    }, label: {
                        Image("backArrow")
                            .resizable()
                            .frame(width: 12, height: 20)
                            .padding()
                    })
                    Spacer()
                    BalanceView()
                }
                Spacer()
            }
            switch stageViewModel.stageState {
            case .preview:
                Stage3PreviewView()
            case .game1:
                Stage3Game1View()
            case .game2:
                Stage3Game2View()
            case .game3:
                Stage3Game3View()
            case .game4:
                Stage3Game4View()
            case .freePlay:
                Stage3FreePlayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
    }
}
