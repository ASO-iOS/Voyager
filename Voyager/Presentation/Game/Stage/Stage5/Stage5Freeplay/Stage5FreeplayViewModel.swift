//
//  Stage5FreeplayViewModel.swift
//  Voyager
//
//  Created by admin on 12/4/23.
//

import SwiftUI

final class Stage5FreePlayViewModel: ObservableObject {
    @Published var state: Stage5FreeplayState = .main
    
    enum Stage5FreeplayState {
        case main, game1, game2, game3, game4
    }
}
