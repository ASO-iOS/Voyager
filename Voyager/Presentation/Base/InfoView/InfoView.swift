//
//  InfoView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

struct InfoView: View {
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
                
                    
                    infoButtomView("Напишите нам") {
                        
                    }

                    
                    infoButtomView("Оцените нас") {
                        
                    }
                    
                    
                    infoButtomView("Политика конфиденциальности") {
                        appRouter.push(route: .privacy)
                    }
                    
                    infoButtomView("Условия использования") {
                        appRouter.push(route: .terms)
                    }
                    
                    infoButtomView("О нас") {
                        appRouter.push(route: .aboutUs)
                    }
                    
                Spacer()

                
            }
        }
        
    }

    
    @ViewBuilder private func infoButtomView(_ text: String, action: @escaping() -> Void ) -> some View {
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
