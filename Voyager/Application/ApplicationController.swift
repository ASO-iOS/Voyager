//
//  ApplicationController.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

final class ApplicationController: ObservableObject {
    
//    @Published  var _balance = StorageManager.shared.gameCash
//    
//    func changeBalance(value: Int, gameResult: GameResultImpl, completion: @escaping (String, Error?) -> Void) {
//        let temp = _balance
//        switch gameResult {
//        case .win:
//            _balance += value
//            StorageManager.shared.setCash(_balance)
//            completion("\(_balance)", nil)
//        case .lose:
//            if temp - value >= 0 {
//                _balance -= value
//                StorageManager.shared.setCash(_balance)
//                completion("\(_balance)", nil)
//            } else {
//                completion("Not enough money", BalanceError())
//            }
//        }
//
//    }
}

struct BalanceError: Error { }
