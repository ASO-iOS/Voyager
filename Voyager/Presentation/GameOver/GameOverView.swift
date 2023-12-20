//
//  GameOverView.swift
//  Voyager
//
//  Created by admin on 12/19/23.
//

import Foundation
import SwiftUI

struct GameOverView: View {
    
    var body: some View {
        ZStack {
            Image("backPreview")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Image("gameOver")
                    .resizable()
                
                Text("Это была славная охота! \nТы отлично давал отпор всем невзгодам которые встречались тебе на пути, но твой славный путь подошёл к своему концу.. \nИли же нет?")
                    .gameButtonStyle(.textBack)
                
                Button(action: {}, label: {
                    Text("Эх... Начинаем по-новой")
                        .gameButtonStyle(.nextButton)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Или докупим еще монет и продолжим?")
                        .gameButtonStyle(.nextButton)
                }) .padding(.bottom, 12)
            }
        }
    }
    
}


//
//#Preview {
//    GameOverView()
//}
