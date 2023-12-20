//
//  GameOverView.swift
//  Voyager
//
//  Created by admin on 12/19/23.
//

import Foundation
import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @State var alertPresented = false
    
    var body: some View {
        ZStack {
            Image("backPreview")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Image("gameOver")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 12)
                
                Text("Это была славная охота! \nТы отлично давал отпор всем невзгодам которые встречались тебе на пути, но твой славный путь подошёл к своему концу.. \nИли же нет?")
                    .gameButtonStyle(.textBack)
                
                Button(action: {
                    alertPresented.toggle()
                }, label: {
                    Text("Эх... Начинаем по-новой")
                        .gameButtonStyle(.nextButton)
                })
                Button(action: {
                    appRouter.push(route: .shop)
                }, label: {
                    Text("Или докупим еще монет и продолжим?")
                        .gameButtonStyle(.nextButton)
                }) .padding(.bottom, 12)
            }
        }
        .alert(isPresented: $alertPresented, content: {
            Alert(title: Text("Начнем по новой"), message: Text("Вы можете сбросить весь прогресс игры, или просто выйти в меню"), primaryButton: .default(Text("Выйти"), action: {
                appRouter.push(route: .main)
            }), secondaryButton: .destructive(Text("Сбросить"), action: {
                StorageManager.shared.setCurrentStage(CurrentStageState.stage1)
                StorageManager.shared.setStage1State(GameStageState.preview)
                StorageManager.shared.setStage2State(GameStageState.preview)
                StorageManager.shared.setStage3State(GameStageState.preview)
                StorageManager.shared.setStage4State(GameStageState.preview)
                StorageManager.shared.setStage5State(GameStageState.preview)
                StorageManager.shared.resetFirstGamePlayed()
                StorageManager.shared.resetKarma()
                currentStageState.route = .stage1
                BalanceManager.shared.reset()
                StorageManager.shared.toggleIsNewGame()
                appRouter.popToRoot()
            }))
        })
    }
    
}


//
//#Preview {
//    GameOverView()
//}
