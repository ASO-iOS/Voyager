//
//  ApplicationController.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

final class ApplicationController: ObservableObject {
    
    @Published private(set) var _balance = StorageManager.shared.gameCash
    
    func increaseBalance(_ value: Int) {
        _balance += value
        StorageManager.shared.setCash(_balance)
    }
    
    func reduceBalance(_ value: Int) {
        var temp = _balance
        if temp - value >= 0 {
            _balance -= value
            StorageManager.shared.setCash(_balance)
        }
    }
}

