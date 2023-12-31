//
//  Stage3ViewModel.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import Combine
import Foundation

final class Stage3ViewModel: ObservableObject {
    
    @Published var stageState = StorageManager.shared.stage3State
    
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
            StorageManager.shared.setStage3State(state)
            self.stageState = StorageManager.shared.stage3State
        }
    }
    
    func setBackImages(background: String, character: String) {
        self.background = background
        self.character = character
    }
}
