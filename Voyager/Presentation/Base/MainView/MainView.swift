//
//  MainView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
    
    
    var body: some View {
        
        ZStack {
            
            VStack {
                HStack {
                    if mainViewModel._gameStatus == .continueGame {
                        Text(currentStageState.route?.value ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 32).monospaced().weight(.black))
                    }
                        
                    Spacer()
                    BalanceView(withPadding: false)
                        
                }.frame(width: UIScreen.main.bounds.width * 0.9)
                .padding(.top, 10)
                Spacer()
            }
            Image("mc")
                .resizable()
                .scaledToFit()
            
            VStack {
    
                
                
                Spacer()
                
                
                mainButtomView(mainViewModel._gameStatus == .newGame ? "Новая игра" : "Продолжить") {
                    if mainViewModel._gameStatus == .newGame {
                        mainViewModel.startNewGame()
                    }
                    appRouter.push(route: .game)
                }
                
                mainButtomView("Информация") {
                    appRouter.push(route: .info)
                }
                
                mainButtomView("Настройки", action: {
                    appRouter.push(route: .settings)
                })
                
                .padding(.bottom, 100)
            }
        }
    }
    
    @ViewBuilder private func mainButtomView(_ text: String, action: @escaping() -> Void ) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .frame(height: 40)
                .font(.system(size: 24))
                .padding(3)
                .foregroundStyle(.white)
                .font(.system(size: 18).monospaced().weight(.bold))
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .background(.nextButton)
                .border(Color.black, width: 2)
        })
        
    }
    
}


//import UIPilot

//struct MainView: View {
////    @EnvironmentObject var pilot: UIPilot<String>
//    @EnvironmentObject var mainViewModel: MainViewModel
//    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
//    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                StorageManager.shared.setCurrentStage(.stage1)
//                currentStageState.push(route: .stage1)
//                StorageManager.shared.setStage1State(.freePlay)
//                appRouter.push(route: .game)
//            }, label: {
//                Text("Stage1 fp")
//            })
//            Button(action: {
//                StorageManager.shared.setCurrentStage(.stage2)
//                currentStageState.push(route: .stage2)
//                StorageManager.shared.setStage2State(.freePlay)
//                appRouter.push(route: .game)
//            }, label: {
//                Text("Stage2 fp")
//            })
//            Button(action: {
//                StorageManager.shared.setCurrentStage(.stage3)
//                currentStageState.push(route: .stage3)
//                StorageManager.shared.setStage3State(.freePlay)
//                appRouter.push(route: .game)
//            }, label: {
//                Text("Stage3 fp")
//            })
//            Button(action: {
//                StorageManager.shared.setCurrentStage(.stage4)
//                currentStageState.push(route: .stage4)
//                StorageManager.shared.setStage4State(.freePlay)
//                appRouter.push(route: .game)
//            }, label: {
//                Text("Stage4 fp")
//            })
//            Button(action: {
//                StorageManager.shared.setCurrentStage(.stage5)
//                currentStageState.push(route: .stage5)
//                StorageManager.shared.setStage5State(.freePlay)
//                appRouter.push(route: .game)
//            }, label: {
//                Text("Stage5 fp")
//            })
//            Button(action: {
//                StorageManager.shared.setCurrentStage(.final)
//                currentStageState.push(route: .final)
//                appRouter.push(route: .game)
//            }, label: {
//                Text("Final")
//            })
//            
//            Button(action: {
//
//                appRouter.push(route: .game)
//
//            }, label: {
//                Text("Game")
//            })
//            Button(action: {
//                appRouter.push(route: .info)
//            }, label: {
//                Text("info")
//            })
//            Button(action: {
//                StorageManager.shared.setStage1State(.preview)
//                StorageManager.shared.setStage2State(.preview)
//                StorageManager.shared.setStage3State(.preview)
//                StorageManager.shared.setStage4State(.preview)
//                StorageManager.shared.setStage5State(.preview)
//                StorageManager.shared.setCurrentStage(.stage1)
//                currentStageState.route = .stage1
//                BalanceManager.shared.reset()
//            }, label: {
//                Text("reset")
//            })
//        }
//    }
//}

//#Preview {
//    MainView()
//}
