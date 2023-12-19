//
//  SmartPhoneView.swift
//  Voyager
//
//  Created by mnats on 15.12.2023.
//
import SwiftUI
struct SmartPhoneView<Content>: View where Content: View {
    var size: CGFloat = 150
    var background: () -> Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.15)
                .foregroundStyle(.black)
            background()
                .frame(width: size * 0.9, height: size * 1.35)
            VStack {
                Spacer()
                Circle()
                    .stroke(lineWidth: size / 100)
                    .foregroundStyle(.gray)
                    .frame(width: size * 0.2)
                    .padding(size * 0.05)
            }
        }
        .frame(width: size, height: size * 2)
    }
}
