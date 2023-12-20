//
//  AppRouter.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct AppRouter: View {
    @StateObject private var appNavRouter = NavRouter<AppRouteState>(route: StorageManager.shared.onboardingPresented ? .main : .onboarding)
    @StateObject private var currentStageState = NavRouter<CurrentStageState>(route: StorageManager.shared.currentStageState)
    
    var body: some View {
        ZStack {
            
            Image("backPreview")
                .resizable()
                .ignoresSafeArea(.all)
        
            Group {
                switch appNavRouter.route {
                case .onboarding:
                    OnboardingView()
                        .environmentObject(OnboardingViewModel())

                case .game:
                    GameView()
                case .info:
                    InfoView()
                case .settings:
                    SettingsView()
                case .textSize:
                    TextSizeView()
                case .textSpeed:
                    TextSpeedView()
                case .privacy:
                    PolicyView()
                case .terms:
                    PolicyView()
                case .aboutUs:
                    AboutUsView()
                    
                default:
                    MainView()
                        .environmentObject(MainViewModel())
                        
                }
            }
            .transition(.move(edge: appNavRouter.direction == .forward ? .trailing : .leading))
            .environmentObject(appNavRouter)
            .environmentObject(currentStageState)
        }
        
    }
}

enum AppRouteState: NavHost {
    case onboarding
    case main
    case game
    case info
    case settings
    case textSpeed
    case textSize
    case privacy
    case terms
    case aboutUs
}
enum GameStageState: String, NavHost {
    case preview
    case game1
    case game2
    case game3
    case game4
    case freePlay
}

enum CurrentStageState: String, NavHost {
    case stage1
    case stage2
    case stage3
    case stage4
    case stage5
    
    var value: String {
        switch self {
        case .stage1:
            return "Глава 1"
        case .stage2:
            return "Глава 2"
        case .stage3:
            return "Глава 3"
        case .stage4:
            return "Глава 4"
        case .stage5:
            return "Глава 5"
        }
    }
}
