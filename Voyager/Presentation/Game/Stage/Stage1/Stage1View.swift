//
//  Stage1View.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

struct Stage1View: View {
    
    @EnvironmentObject var stageViewModel: Stage1ViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
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
                        Text("\(stageViewModel.appController._balance)")
                            .foregroundStyle(.white)
                            .font(.system(size: 18).monospaced().bold())
                            .padding(.trailing)
//                            .onChange(of: Balance.balance, perform: {
//                                _ in
//                                print("balance changed")
//                            })
//                            .onChange(of: StorageManager.shared.gameCash, perform: { value in
//                                print("StorageManager balance changed")
//                            })
                    }
                }
                Spacer()
            }

            switch stageViewModel.stageState {
            case .preview:
                Stage1PreviewView()
            case .game1:
                Stage1Game1View()
            case .game2:
                Stage1Game2View()
            case .game3:
                Stage1Game3View()
            case .game4:
                Stage1Game4View()
            case .freePlay:
                Stage1FreeplayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
//        .environmentObject(balanceManager)
//        .environmentObject(appController)
        
    }
}
