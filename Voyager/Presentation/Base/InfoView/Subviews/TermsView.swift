//
//  TermsView.swift
//  Voyager
//
//  Created by admin on 20.12.2023.
//

import SwiftUI

struct TermsView: View {
    
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
