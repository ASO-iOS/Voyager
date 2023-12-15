
import Combine

final class LoteryViewModel: ObservableObject {
    
    @Published private(set) var _gameStatus: GameStatus = .game
    
    @Published var numberHidden = true
    
    @Published var firstStep =  true
    @Published var secondStep = false
    @Published var thirdStep = false
    
    
    var winChanse = [1,2,3,4,5,6,7,8,9,10].shuffled()
    
    func setGame() {
        _gameStatus = .game
        firstStep =  true
        secondStep = false
        thirdStep = false
        winChanse = winChanse.shuffled()
        
    }
    func setResult() {
        _gameStatus = .result
    }
    
    enum GameStatus {
        case game
        case result
    }
}
