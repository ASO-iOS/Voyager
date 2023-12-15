//MARK: - UPD
import Combine

final class UpdetedSportBettingViewModel: ObservableObject {
    
    @Published private(set) var _gameStatus: GameStatus = .firstQ
    
    @Published var playerRate = 0.0
    
    @Published var playerBetSize = 0
    
    var sizeBet = [100, 200, 300]
    
    var rate = [1.8, 1.9, 2.0, 2.1, 2.2].shuffled()
    
    func setChooseFirstQ() {
        _gameStatus = .firstQ
    }
    
    func setChooseSecondQ() {
        playerRate = 0.0
        playerBetSize = 0
        rate = rate.shuffled()
        _gameStatus = .secondQ
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
       case 3.6:
           winChance = 0.66
       case 3.7:
           winChance = 0.64
       case 3.8:
           winChance = 0.62
       case 3.9:
           winChance = 0.60
       case 4.0:
           winChance = 0.58
       case 4.1:
           winChance = 0.56
       case 4.2:
           winChance = 0.54
       case 4.3:
           winChance = 0.52
           
       default:
           winChance = 0.50
       
       }
       
       let random = Double.random(in: 0..<1)
       return random <= winChance
   }
    
    enum GameStatus {
        
case firstQ, secondQ, chooseBet, animation, result
        
}
    
}
