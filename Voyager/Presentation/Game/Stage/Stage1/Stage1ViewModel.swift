//
//  Stage1ViewModel.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

final class Stage1ViewModel: ObservableObject {
    
    @Published var stageState = StorageManager.shared.stage1State
    @Published var background = ""
    @Published var character = ""
    @Published var delay = UInt64(StorageManager.shared.textSpeed)
    
    func resetDelay() {
        delay = UInt64(StorageManager.shared.textSpeed)
    }
    
    func skipText() {
        delay = 0
    }
    
    func setState(_ state: GameStageState) {
        DispatchQueue.main.async {
            StorageManager.shared.setStage1State(state)
            self.stageState = StorageManager.shared.stage1State
        }
    }
    
    func setBackImages(background: String, character: String) {
        self.background = background
        self.character = character
    }
}
