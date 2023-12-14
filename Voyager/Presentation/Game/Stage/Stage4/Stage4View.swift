//
//  Stage4View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage4View: View {
    
    @EnvironmentObject var stageViewModel: Stage4ViewModel
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
                Stage4PreviewView()
            case .game1:
                Stage4Game1View()
            case .game2:
                Stage4Game2View()
            case .game3:
                Stage4Game3View()
            case .game4:
                Stage4Game4View()
            case .freePlay:
                Stage4FreePlayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
    }
}
//
//struct Stage4FreePlayView: View {
//    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
//    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
//    var body: some View {
//        VStack {
//            Text("free play")
//            Button(action: {
//                currentStageState.push(route: .stage5)
//                StorageManager.shared.setCurrentStage(.stage5)
//            }, label: {
//                Text("stage 5")
//            })
//        }
//    }
//}

