//
//  TextSizeView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import Foundation
import SwiftUI

struct TextSizeView: View {
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @State private var textSize = StorageManager.shared.textSize
    
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
                
                Text("Здесь вы можете отрегулировать размер текста так, что бы вам было комфортно играть")
                    .frame(height: 120)
                    .font(.system(size: 24))
                    .padding(12)
                    .foregroundStyle(.white)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background(.nextButton)
                    .border(Color.black, width: 5)
                
                HStack {
                    Button(action: {
                        StorageManager.shared.textSizeDown()
                        textSize = StorageManager.shared.textSize
                    }, label: {
                        Image("down")
                    })
                    
                    Text("\(textSize)")
                        .frame(height: 50)
                        .font(.system(size: 24))
                        .padding(12)
                        .foregroundStyle(.white)
                        .font(.system(size: 18).monospaced().weight(.bold))
                        .frame(width: UIScreen.main.bounds.width * 0.4)
                        .background(.nextButton)
                        .border(Color.black, width: 5)
                    
                    Button(action: {
                        StorageManager.shared.textSizeUp()
                        textSize = StorageManager.shared.textSize
                    }, label: {
                        Image("up")
                    })
                    
                    
                }
                
                Spacer()
                
            }
        }
    }
}
