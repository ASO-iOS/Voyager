//
//  Stage4FreePlayViewModel.swift
//  Voyager
//
//  Created by admin on 14.12.2023.
//

import SwiftUI

final class Stage4FreePlayViewModel: ObservableObject {
    @Published var state: Stage4FreeplayState = .main
    
    enum Stage4FreeplayState {
        case main, game1, game2, game3, game4
    }
}
