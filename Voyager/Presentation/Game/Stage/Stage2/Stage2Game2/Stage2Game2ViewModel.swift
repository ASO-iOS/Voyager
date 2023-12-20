import Combine

final class Stage2Game2ViewModel: ObservableObject {
    @Published var state: Stage2GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage2DiceReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    
    
    enum Stage2GameState {
        case text0, text1, text2, text3, text4, text5, game, textSide0, textSide1, textSideNegative, textSideNeutral, textSidePositive0, textSidePositive1
    }
    
    func nextText(_ state: Stage2GameState) {
        if index < Stage2DiceReference.shared.phrases.count - 1 {
            self.state = state
            if state != .game {
                index += 1
            }
            textOutput = ""
            phraseSource = Stage2DiceReference.shared.phrases[index]
        } else {
            textOutput = ""
            self.state = state
        }
    }
}
