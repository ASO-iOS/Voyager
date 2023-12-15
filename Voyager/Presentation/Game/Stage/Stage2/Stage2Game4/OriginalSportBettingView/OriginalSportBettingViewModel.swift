//MARK: - UPD
import Combine

final class OriginalSportBettingViewModel: ObservableObject {
    
    @Published private(set) var _gameStatus: GameStatus = .chooseTeam
    
    @Published var playerRate = 0.0
    
    @Published var playerBetSize = 0
    
    var teamsArray  = ["ЦСКА", "Спартак", "Динамо", "Торпедо", "Локомотив"].shuffled()
    
    var winRate = [1.1, 1.4, 1.3, 1.6, 1.5, 1.8, 2.0, 2.1, 2.5, 2.3, 2.6].shuffled()
    
    var drawRate = [3.0, 3.1, 3.3, 2.7, 2.9, 3.5, 3.7].shuffled()
    
    var sizeBet = [100, 200, 300]
    
    func resetGame() {
        self.playerRate = 0.0
        self.playerBetSize = 0
        self.winRate = self.winRate.shuffled()
        self.drawRate = self.drawRate.shuffled()
        self._gameStatus = .chooseTeam
    }
    
    func setChooseTeam() {
        _gameStatus = .chooseTeam
    }
    
    func setChooseBet() {
        _gameStatus = .chooseBet
    }
    func setAnimation() {
        _gameStatus = .animation
    }
    func setResult() {
        _gameStatus = .result
    }
    
     func determineWin() -> Bool {
        let winChance: Double
        
        switch playerRate {
        case 1.1:
            winChance = 0.97
        case 1.2:
            winChance = 0.90
        case 1.3:
            winChance = 0.85
        case 1.4:
            winChance = 0.75
        case 1.5:
            winChance = 0.65
        case 1.6:
            winChance = 0.55
        case 1.7:
            winChance = 0.50
        case 1.8:
            winChance = 0.45
        case 1.9:
            winChance = 0.35
        case 2.0:
            winChance = 0.32
        case 2.1:
            winChance = 0.30
        case 2.3:
            winChance = 0.28
        case 2.4:
            winChance = 0.26
        case 2.5:
            winChance = 0.24
        case 2.6:
            winChance = 0.22
        case 2.7:
            winChance = 0.20
        case 2.8:
            winChance = 0.18
        case 2.9:
            winChance = 0.16
        case 3.0:
            winChance = 0.14
        case 3.1:
            winChance = 0.12
        case 3.2:
            winChance = 0.10
        case 3.3:
            winChance = 0.08
        case 3.4:
            winChance = 0.06
        case 3.5:
            winChance = 0.04
        case 3.6:
            winChance = 0.02
        case 3.7:
            winChance = 0.01
        default:
            winChance = 0.01
        
        }
        
        let random = Double.random(in: 0..<1)
        return random <= winChance
    }
    
    enum GameStatus {
        case chooseTeam, chooseBet, animation, result
    }
}
