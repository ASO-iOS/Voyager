//
//  MainView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI
import UIPilot

struct MainView: View {
//    @EnvironmentObject var pilot: UIPilot<String>
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
    var body: some View {
        VStack {
            Button(action: {
                StorageManager.shared.setCurrentStage(.stage1)
                currentStageState.push(route: .stage1)
                StorageManager.shared.setStage1State(.freePlay)
                appRouter.push(route: .game)
            }, label: {
                Text("Stage1 fp")
            })
            Button(action: {
                StorageManager.shared.setCurrentStage(.stage2)
                currentStageState.push(route: .stage2)
                StorageManager.shared.setStage2State(.freePlay)
                appRouter.push(route: .game)
            }, label: {
                Text("Stage2 fp")
            })
            Button(action: {
                StorageManager.shared.setCurrentStage(.stage3)
                currentStageState.push(route: .stage3)
                StorageManager.shared.setStage3State(.freePlay)
                appRouter.push(route: .game)
            }, label: {
                Text("Stage3 fp")
            })
            Button(action: {
                StorageManager.shared.setCurrentStage(.stage4)
                currentStageState.push(route: .stage4)
                StorageManager.shared.setStage4State(.freePlay)
                appRouter.push(route: .game)
            }, label: {
                Text("Stage4 fp")
            })
            Button(action: {
                StorageManager.shared.setCurrentStage(.stage5)
                currentStageState.push(route: .stage5)
                StorageManager.shared.setStage5State(.freePlay)
                appRouter.push(route: .game)
            }, label: {
                Text("Stage5 fp")
            })
            Button(action: {
                
                appRouter.push(route: .game)
                
            }, label: {
                Text("Game")
            })
            Button(action: {
                appRouter.push(route: .info)
            }, label: {
                Text("info")
            })
            Button(action: {
                StorageManager.shared.setStage1State(.preview)
                StorageManager.shared.setStage2State(.preview)
                StorageManager.shared.setStage3State(.preview)
                StorageManager.shared.setStage4State(.preview)
                StorageManager.shared.setStage5State(.preview)
                StorageManager.shared.setCurrentStage(.stage1)
                currentStageState.route = .stage1
                BalanceManager.shared.reset()
            }, label: {
                Text("reset")
            })
        }
    }
}

//#Preview {
//    MainView()
//}
