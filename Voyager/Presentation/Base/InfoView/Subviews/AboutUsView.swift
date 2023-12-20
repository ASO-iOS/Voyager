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
                Spacer()
            }.zIndex(10)
            
            ScrollView(showsIndicators: false) {
                HStack {
                    Image("mc").resizable()
                        .frame(width: iconW, height: iconW)
                        .cornerRadius(40)
                } .padding(.bottom, 10).padding(.top, 32)
                
                Text("Version \(bundleVers) (build \(buildVers))").font(.headline) .foregroundColor(.white)
                
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
                
                ForEach(PhraseType.allCases, id: \.self) { image in
                    if image != PhraseType.common {
                        AboutImageView(image: image.imageName)
                    }
                    
                }
            }
        }
    }
}

struct AboutImageView: View {
    let image: String
    
    @State private var isRotated = false
    
    var animation: Animation {
        Animation.easeOut
    }
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 32)
            .padding()
            .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
            .animation(animation, value: isRotated)
            .onTapGesture {
                isRotated.toggle()
            }
    }
}
