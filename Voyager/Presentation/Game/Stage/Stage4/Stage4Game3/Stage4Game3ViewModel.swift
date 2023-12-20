//
//  Stage4Game2ViewModel.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import Combine

final class Stage4Game3ViewModel: ObservableObject {
    @Published var state: Stage4GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage4SlotReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    enum Stage4GameState {
        case text0, text1, text2, text3, text4, text5, text6, text7, game, textSide0, textSide1, textSideNegative0, textSideNegative1, textSideNeutral, textSidePositive0, textSidePositive1
    }
    
    func nextText(_ state: Stage4GameState) {
        if index < Stage4SlotReference.shared.phrases.count - 1 {
            self.state = state
            if state != .game {
                index += 1
            }
            textOutput = ""
            phraseSource = Stage4SlotReference.shared.phrases[index]
        } else {
            textOutput = ""
            self.state = state
        }
    }
}
