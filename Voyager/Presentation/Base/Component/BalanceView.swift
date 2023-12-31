//
//  BalanceView.swift
//  Voyager
//
//  Created by admin on 14.12.2023.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject var displayCash = BalanceManager.shared
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    var withPadding: Bool = true
    var body: some View {
        HStack {
            
            Button(action: {
                appRouter.push(route: .shop)
            }, label: {
                Image("shop")
                    .resizable()
                    .frame(width: 24, height: 24)
            })
            
            Image("coin_balance")
                .resizable()
                .frame(width: 30, height: 30)
            if withPadding {
                Text("\(displayCash.balance)")
                    .foregroundStyle(.white)
                    .font(.system(size: 18).monospaced().bold())
                    .padding(.trailing)
            } else {
                Text("\(displayCash.balance)")
                    .foregroundStyle(.white)
                    .font(.system(size: 18).monospaced().bold())
            }
            
        }
        .onReceive(displayCash.$lowBalance, perform: { value in
            if value && appRouter.route != .main {
                appRouter.push(route: .gameOver)
            }
        })
//        .onAppear {
//            print(#function)
//            if displayCash.lowBalance {
//                print("balance 0")
//            }
//        }
//        .onChange(of: BalanceManager.shared.$lowBalance) { newValue in
//            if newValue {
//                print("balance 0")
//            }
//        }
    }
}
