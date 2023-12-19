//
//  SettingsView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settinsViewModel: SettingsViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    var body: some View {

        ZStack {
//            Image("backPreview")
//                .resizable()
//                .ignoresSafeArea(.all)
            
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
                }
                .padding()
                
                settingsButtomView("Скорость текста") {
                    appRouter.push(route: .textSpeed)
                }
                
                settingsButtomView("Размер шрифта") {
                    appRouter.push(route: .textSize)
                }
                
                
                settingsButtomView("Сброс прогресса (частичный)") {
                    
                }
                
                settingsButtomView("Сброс прогресса (полный)") {
                    
                }
                Spacer()
                
            }
        }
        
    }
    
    
    @ViewBuilder private func settingsButtomView(_ text: String, action: @escaping() -> Void ) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .frame(height: 46)
                .font(.system(size: 21))
                .gameButtonStyle(.nextButton)
        })
        .padding(.bottom, 12)
        
    }
}
