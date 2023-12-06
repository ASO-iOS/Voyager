//
//  ViewExtension.swift
//  Voyager
//
//  Created by admin on 06.12.2023.
//

import SwiftUI

extension View {
    func gameButtonStyle(_ backgroundColor: Color, width: CGFloat = UIScreen.main.bounds.width * 0.9) -> some View {
        self.modifier(GameButtonModifier(backgroundColor: backgroundColor, width: width))
    }
}