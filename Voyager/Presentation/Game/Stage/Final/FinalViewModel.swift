//
//  FinalViewModel.swift
//  Voyager
//
//  Created by admin on 20.12.2023.
//

import Combine

final class FinalViewModel: ObservableObject {
    @Published var state = FinalState.text0
    @Published var textOutput = ""
    @Published var index = 0
    @Published var printingFinished = false
    @Published var phraseSource = FinalReference.shared.phrases[0]
    @Published var background = ""
    @Published var character = ""
    

    
    func nextText(_ state: FinalState) {
        if index < FinalReference.shared.phrases.count - 1 {
            self.state = state
            index = stateToIndex(state: state)
            textOutput = ""
            phraseSource = FinalReference.shared.phrases[index]
            printingFinished = false
        } else {
            textOutput = ""
            self.state = state
        }
    }
    
    func setBackImages(background: String, character: String) {
        self.background = background
        self.character = character
    }
    
    enum FinalState {
        case text0, text1, text2, text3, text4, text5, text6, text7, text8, text9, text10, text11, text12, text13, text14, text15, text16, text17, text18, text19, text20, text21, text22, textDD, text0n, text1n, text2n, text3n, text4n, text5n, text6n, text7n, text8n, text9n, text10n, text11n, text12n, text13n, text14n, text15n, text16n, text17n, text18n, text19n, text20n, text21n, text22n, text23n, text24n, text25n, text26n, text27n, text28n, text29n, textNR, textPR
    }
    
    func stateToIndex(state: FinalState) -> Int {
        switch state {
        case .text0:
            return 0
        case .text1:
            return 1
        case .text2:
            return 2
        case .text3:
            return 3
        case .text4:
            return 4
        case .text5:
            return 5
        case .text6:
            return 6
        case .text7:
            return 7
        case .text8:
            return 8
        case .text9:
            return 9
        case .text10:
            return 10
        case .text11:
            return 11
        case .text12:
            return 12
        case .text13:
            return 13
        case .text14:
            return 14
        case .text15:
            return 15
        case .text16:
            return 16
        case .text17:
            return 17
        case .text18:
            return 18
        case .text19:
            return 19
        case .text20:
            return 20
        case .text21:
            return 21
        case .text22:
            return 22
        case .textDD:
            return 23
        case .text0n:
            return 24
        case .text1n:
            return 25
        case .text2n:
            return 26
        case .text3n:
            return 27
        case .text4n:
            return 28
        case .text5n:
            return 29
        case .text6n:
            return 30
        case .text7n:
            return 31
        case .text8n:
            return 32
        case .text9n:
            return 33
        case .text10n:
            return 34
        case .text11n:
            return 35
        case .text12n:
            return 36
        case .text13n:
            return 37
        case .text14n:
            return 38
        case .text15n:
            return 39
        case .text16n:
            return 40
        case .text17n:
            return 41
        case .text18n:
            return 42
        case .text19n:
            return 43
        case .text20n:
            return 44
        case .text21n:
            return 45
        case .text22n:
            return 46
        case .text23n:
            return 47
        case .text24n:
            return 48
        case .text25n:
            return 49
        case .text26n:
            return 50
        case .text27n:
            return 51
        case .text28n:
            return 52
        case .text29n:
            return 53
        case .textNR:
            return 54
        case .textPR:
            return 55
        }
    }
}
