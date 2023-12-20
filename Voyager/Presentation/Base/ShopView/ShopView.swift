//
//  ShopView.swift
//  Voyager
//
//  Created by admin on 12/20/23.
//

import Foundation
import SwiftUI


struct ShopView: View {
    
    @EnvironmentObject var  appRouter: NavRouter<AppRouteState>
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Button(action: {
                        appRouter.popToRoot()
                    }, label: {
                        Image("backArrow")
                            .resizable()
                            .frame(width: 20, height: 30)
                            .padding()
                    })
                    
                    Spacer()
                    HStack {
                        Image("coin_balance")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("\(BalanceManager.shared.balance)")
                            .foregroundStyle(.white)
                            .font(.system(size: 18).monospaced().bold())
                    } .padding(.trailing, 8)
                    
                }
                .padding()
                
                HStack {
                    Text("Магазин")
                        .foregroundColor(.white)
                        .font(.system(size: 32, design: .monospaced) .bold())
                        .padding(.leading, 16)
                 Spacer()
                }
                    
                
                shopList(title: "1 000", price: 0.99) {
                }
                
                shopList(title: "2 500", price: 1.99) {
                }
                
                shopList(title: "5 000", price: 2.99) {
                }
                
                shopList(title: "10 000", price: 3.99) {
                }
                
                Spacer()

            }
        }
    }
    
    @ViewBuilder private func shopList(title: String, price: Double,completion: @escaping () -> Void) -> some View {
        VStack {
            HStack {
                HStack {
                    Image("coin_balance")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text("\(title)")
                        .foregroundColor(.white)
                        .font(.system(size: 26, design: .monospaced))
                } .padding(.leading, 8)
                Spacer()
                VStack {
                    Text("\(price, specifier: "%.2f")$")
                        .foregroundColor(.white)
                        .font(.system(size: 20, design: .monospaced))
                        .padding(.bottom, 1)
                    
                    
                        
                    Button(action: {
                        completion()
                    }, label: {
                        Text("Купить")
                            .font(.system(size: 22))
                            .padding(4)
                            .padding(.horizontal, 8)
                            .foregroundStyle(.white)
                            .font(.system(size: CGFloat(StorageManager.shared.textSize)).monospaced().weight(.bold))
                            .frame(alignment: .center)
                            .multilineTextAlignment(.leading)
                            .background(.nextButton)
                            .border(Color.black, width: 2)
                    }) .padding(.top, 1)
                } .padding(.trailing, 24)
            }
        }
    }
    
}


#Preview {
    ShopView()
}
