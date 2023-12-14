//
//  Stage2View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage2View: View {
    @EnvironmentObject var stageViewModel: Stage2ViewModel
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    
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
                    HStack {
                        Image("coin_balance")
                            .resizable()
                            .frame(width: 30, height: 30)
//                        Text("\(appController._balance)")
//                            .foregroundStyle(.white)
//                            .font(.system(size: 18).monospaced().bold())
//                            .padding(.trailing)
                    }
                }
                Spacer()
            }
            switch stageViewModel.stageState {
            case .preview:
                Stage2PreviewView()
            case .game1:
                Stage2Game1View()
            case .game2:
                Stage2Game2View()
            case .game3:
                Stage2Game3View()
            case .game4:
                Stage2Game4View()
            case .freePlay:
                Stage2FreeplayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
//        .environmentObject(appController)
    }
}

