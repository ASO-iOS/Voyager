//
//  AboutUsView.swift
//  Voyager
//
//  Created by admin on 15.12.2023.
//

import Foundation
import SwiftUI

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}


struct AboutUsView: View {
    
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    var bundleVers:  String = Bundle.main.releaseVersionNumber ?? "1.0"
    var buildVers: String = Bundle.main.buildVersionNumber ?? "1"
    let iconW = UIScreen.main.bounds.width / 3
    
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
                
                HStack {
                    Image("mc").resizable()
                        .frame(width: iconW, height: iconW)
                        .cornerRadius(40)
                } .padding(.bottom, 10)
                
                Text("Version \(bundleVers) (build \(buildVers))").font(.headline) .foregroundColor(.white)
                
//                Text("""
//            Над этим невероятным приложением на протяжении долгих лет не покладая своих мышек и клавиатур работали
//            Дизайнеры: \(getNikitas())
//            Разработчики: Миро Милёхин, Кармелита Рамировна Зарецкая, Леонид Форс, Баро, Антон Николаевич Астахов
//            """
//                )      
                Text("""
            Над этим невероятным приложением на протяжении долгих лет не покладая своих мышек и клавиатур работали
            Дизайнеры: Никита, Никита,  Никита, Никита,  Никита, Никита, Никита, Никита, Никита, Никита
            Разработчики: Миро Милёхин, Кармелита Рамировна Зарецкая, Леонид Форс, Баро, Антон Николаевич Астахов
            """
                )
                .gameTextStyle(.nextButton)
                
                
                
                Button {
                    
                } label: {
                    Text("Share App")
                        .foregroundColor(.white)
                        .font(.system(size: 16) .bold())
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.nextButton.opacity(1))
                        .cornerRadius(8)
                } .buttonStyle(.plain)
                
                Spacer()
                
                
                
            }
        }
    }
    
//    private func getNikitas() -> String {
//        let nikitaCount = Int.random(in: 4...12)
//        var nikitaArray: [Nikita] = []
//        for i in 0...nikitaCount {
//            let spacers = Int.random(in: 0...4)
//        }
//        let array = [Nikita](repeating: Nikita(spacers: Int.random(in: 0...4)), count: Int.random(in: 5...12))
//        var result = ""
//        array.forEach { nikita in
//            result += "Никита"
//            for _ in 0...nikita.spacers {
//                result += " "
//            }
//            result += ","
//        }
//        return result
//    }
//    
//    struct Nikita {
//        let
//        let spacers: Int
//    }
}

