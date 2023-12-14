//
//  Stage5View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage5View: View {
    
    @EnvironmentObject var stageViewModel: Stage5ViewModel
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
                Stage5PreviewView()
            case .game1:
                Stage5Game1View()
            case .game2:
                Stage5Game2View()
            case .game3:
                Stage5Game3View()
            case .game4:
                Stage5Game4View()
            case .freePlay:
                Stage5FreePlayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
    }
}




struct Stage5FreePlayView: View {
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    var body: some View {
        VStack {
            Text("free play")
//            Button(action: {
//                currentStageState.push(route: .stage5)
//                StorageManager.shared.setCurrentStage(.stage5)
//            }, label: {
//                Text("stage 5")
//            })
        }
    }
}


