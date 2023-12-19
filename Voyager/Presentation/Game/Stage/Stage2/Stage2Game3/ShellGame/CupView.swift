//
//  Cup.swift
//  dices
//
//  Created by mnats on 20.11.2023.
//

//MARK: - UPDATE

import SwiftUI

struct CupView: View {
    var id: Int
    @Binding var reveal: Bool
    @State private var isUp = false
    @State var isCoinPresent = true
    var winChance: Float
    var onCupRevealed: (Bool) -> ()
    
    private var karmaBonus: Double  {
        switch StorageManager.shared.gameKarma {
        case 0:
            return -0.25
            
        case 5:
            return -0.225
            
        case 10:
            return -0.2
            
        case 15:
            return -0.175
            
        case 20:
            return -0.15
            
        case 25:
            return -0.125
            
        case 30:
            return -0.1
            
        case 35:
            return -0.075
            
        case 40:
            return -0.050
            
        case 45:
            return -0.025
            
        case 50:
            return 0
            
        case 55:
            return 0.025
            
        case 60:
            return 0.050
            
        case 65:
            return 0.075
            
        case 70:
            return 0.1
            
        case 75:
            return 0.125
            
        case 80:
            return 0.15
            
        case 85:
            return 0.175
            
        case 90:
            return 0.20
            
        case 95:
            return 0.225
            
        case 100:
            return 0.25
            
            
        default:
            return 0
        }
    }
    
    init(id: Int, reveal: Binding<Bool> = .constant(false), winChance: Float = 1, onCupRevealed: @escaping (Bool) -> () = {_ in}) {
        self.id = id
        self._reveal = reveal
        self.isUp = false
        self.isCoinPresent = true
        self.winChance = winChance
        self.onCupRevealed = onCupRevealed
    }
    
    func openCup() {
        isCoinPresent = winChance + Float(karmaBonus) > Float.random(in: 0...1)
        moveUpDown()
        onCupRevealed(isCoinPresent)
    }
    
    func moveUpDown() {
        guard !isUp else { return }
        Task {
            withAnimation {
                isUp = true
            }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation {
                isUp = false
            }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            isCoinPresent = false
        }
    }
    
    var body: some View {
        ZStack {
            Image("cup")
                .resizable()
                .offset(y: isUp ? -70 : 0)
                .aspectRatio(1, contentMode: .fit)
                .background {
                    if isCoinPresent {
                        Image("coin")
                            .scaleEffect(isUp ? 0.25 : 0.1)
                            .offset(y: isUp ? 30 : 0)
                    }
                }
        }
        .onTapGesture {
            openCup()
        }
        .onChange(of: reveal) { _ in
            isCoinPresent = true
            moveUpDown()
        }
    }
}
