//
//  Stage1Game1ViewModel.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import Combine

final class Stage1Game1ViewModel: ObservableObject {
    @Published var state: Stage1GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage1ThimblesReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    enum Stage1GameState {
        case text0, text1, text2, text3, text4, text5, text6, text7, game, textSide0, textSide1, textSide2, textSideNegative, textSideNeutral, textSidePositive0, textSidePositive1, textSidePositive2, textSidePositive3, textSidePositive4
    }
    
    func nextText(_ state: Stage1GameState) {
        if index < Stage1ThimblesReference.shared.phrases.count - 1 {
            self.state = state
            if state != .game {
                index += 1
            }
            textOutput = ""
            phraseSource = Stage1ThimblesReference.shared.phrases[index]
        } else {
            textOutput = ""
            self.state = state
        }
    }
}
