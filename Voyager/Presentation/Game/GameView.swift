//
//  GameView.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
    var body: some View {
        ZStack {
            Group {
                switch currentStageState.route {
                case .stage1:
                    Stage1View()
                        .environmentObject(Stage1ViewModel())
                case .stage2:
                    Stage2View()
                        .environmentObject(Stage2ViewModel())
                case .stage3:
                    Stage3View()
                        .environmentObject(Stage3ViewModel())
                case .stage4:
                    Stage4View()
                        .environmentObject(Stage4ViewModel())
                case .stage5:
                    Stage5View()
                        .environmentObject(Stage5ViewModel())
                default:
                    FinalView()
                }
            }
            .environmentObject(currentStageState)
            .environmentObject(appRouter)
        }
    }
}
