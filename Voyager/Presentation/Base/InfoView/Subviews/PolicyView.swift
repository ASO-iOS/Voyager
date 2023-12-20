//
//  PolicyView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import SwiftUI

struct PolicyView: View {
    
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
                            .frame(width: 20, height: 30)
                            .padding()
                    })
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                VStack {
                    Text("111")
                    Text("123")
                }
                Spacer()
            }
        }
    }
}
