//MARK: - UPD
import SwiftUI
import Foundation

final class SlotMashineViewModel: ObservableObject {
    
    init(betAmount: Int) {
        self.betAmount = betAmount
    }
    
    @Published private(set) var _gameStatus: GameStatus = .chooseDepositSize
    
    @Published var depositeSize = 30
    
    var maxDepositeSize = 0
    
    @Published var spinCount = 0
    
    @Published var imageOffset: CGFloat = 0
    
    @Published var isPlaying = false
    
    var betAmount: Int
    
    @Published var depositeBackColor = Color.textBack
    
    
    
     var symbols = ["slot1", "slot2", "slot3","slot4", "slot5", "slot6", "slot7", "slot8", "slot9"]
    
    @Published var numbers = [1, 2, 0, 5, 4, 3, 8, 7, 6]
    
    func setChooseDepositteSize() {
        _gameStatus = .chooseDepositSize
    } 
    func setPlaying() {
        _gameStatus = .playing
    }
    func setResult() {
        BalanceManager.shared.changeBalance(by: depositeSize, gameResult: .win)
        _gameStatus = .result
    }
    
    
    func startSlotAnimation() {
        depositeSize -= betAmount
        depositeBackColor = .textBack
        isPlaying = true
        let maxSpins = 10
        var spins = 0
        
        spinCount += 1

        Timer.scheduledTimer(withTimeInterval: 0.17, repeats: true) { [self] timer in
            spins += 1
            
            
            numbers[0] = Int.random(in: 0..<symbols.count - 1)
            numbers[1] = Int.random(in: 0..<symbols.count - 1)
            numbers[2] = Int.random(in: 0..<symbols.count - 1)
            
            numbers[3] = Int.random(in: 0..<symbols.count - 1)
            numbers[4] = Int.random(in: 0..<symbols.count - 1)
            numbers[5] = Int.random(in: 0..<symbols.count - 1)
            
            numbers[6] = Int.random(in: 0..<symbols.count - 1)
            numbers[7] = Int.random(in: 0..<symbols.count - 1)
            numbers[8] = Int.random(in: 0..<symbols.count - 1)
            
            if spins >= maxSpins {
                timer.invalidate()
                isPlaying = false
                
                let winCon = Int.random(in: 0...8)
                
//                if spinCount % 2 == 0 {
                if spinCount % (Int(maxDepositeSize / 3 / betAmount) + 1) == 0 {
                    numbers[0] = winCon
                    numbers[4] = winCon
                    numbers[8] = winCon
                    
                        calculateSpin()
//                    setResult()
                } else {
                    calculateSpin()
//                    setResult()
                }
                
                if depositeSize >= maxDepositeSize {
                    setResult()
                    
                }
                
                if depositeSize < 0 {
                    setResult()
                }
               

            }
            
        }
    }
        
    
    func calculateSpin() {
        
        if numbers[0] == numbers[1] && numbers[1] == numbers[2] {
            
            depositeSize += betAmount * 6
            print("Wiin")
        }
        
         else if numbers[3] == numbers[4] && numbers[4] == numbers[5] {
            
            depositeSize += betAmount * 6
             print("Wiin")
        }
    
        else if numbers[6] == numbers[7] && numbers[7] == numbers[8] {
           
           depositeSize += betAmount * 6
            print("Wiin")
       }
        
        else if numbers[0] == numbers[3] && numbers[3] == numbers[6] {
           
           depositeSize += betAmount * 6
            print("Wiin")
       }
        
        else if numbers[1] == numbers[4] && numbers[4] == numbers[7] {
           
           depositeSize += betAmount * 6
            print("Wiin")
       }
        
        else if numbers[2] == numbers[5] && numbers[5] == numbers[8] {
           
           depositeSize += betAmount * 6
            print("Wiin")
       }
        
        else if numbers[0] == numbers[4] && numbers[4] == numbers[8] {
           
           depositeSize += betAmount * 6
            print("Wiin")
       }
        
        else if numbers[2] == numbers[4] && numbers[4] == numbers[6] {
           
           depositeSize += betAmount * 6
            print("Wiin")
        } else {
            depositeBackColor = .red
        }
        
        
        if depositeSize == 0 {
            setResult()
        }
        print(depositeSize)
    }
    
    enum GameStatus {
        case chooseDepositSize
        case playing
        case result
    }
    
}
