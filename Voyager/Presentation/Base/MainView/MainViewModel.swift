//
//  MainViewModel.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import Combine

final class MainViewModel: ObservableObject {
    
    @Published private(set) var _gameStatus: GameStatus = StorageManager.shared.isNewGame ? .newGame : .continueGame

    
    func startNewGame() {
        StorageManager.shared.toggleIsNewGame()
        _gameStatus = .continueGame
    }
    
    enum GameStatus {
        case newGame, continueGame
    }
    
}
