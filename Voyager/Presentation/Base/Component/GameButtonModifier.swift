//
//  GameButtonModifier.swift
//  Voyager
//
//  Created by admin on 11.12.2023.
//
import SwiftUI

struct GameButtonModifier: ViewModifier {
    var backgroundColor: Color
    var width: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(12)
            .foregroundStyle(.white)
            .font(.system(size: 18).monospaced().weight(.bold))
            .frame(width: width)
            .background(backgroundColor)
            .border(Color.black, width: 2)
    }
}

struct GameTextModifier: ViewModifier {
    var backgroundColor: Color
    var width: CGFloat
    var fixedHeight: Bool

    func body(content: Content) -> some View {
        if fixedHeight {
            content
                .padding(12)
                .foregroundStyle(.white)
                .font(.system(size: CGFloat(StorageManager.shared.textSize)).monospaced().weight(.bold))
                .frame(minHeight: 160)
                .frame(width: width, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(backgroundColor)
                .border(Color.black, width: 2)
        } else {
            content
                .padding(12)
                .foregroundStyle(.white)
                .font(.system(size: CGFloat(StorageManager.shared.textSize)).monospaced().weight(.bold))
                .frame(width: width, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(backgroundColor)
                .border(Color.black, width: 2)
        }
    }
}
