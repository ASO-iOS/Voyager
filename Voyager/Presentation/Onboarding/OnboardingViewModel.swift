//
//  OnboardingViewModel.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    @Published private(set) var _onbStatus: OnbStatus = .scene0
    
    func setScene0() {
        withAnimation(.bouncy(duration: 0.2)) {
        _onbStatus = .scene0
        }
    }
    
    func setScene1() {
        withAnimation(.bouncy(duration: 0.2)) {
        _onbStatus = .scene1
        }
    }
    
    func setScene2() {
        withAnimation(.bouncy(duration: 0.2)) {
            _onbStatus = .scene2
        }
        
    }
    
    func setScene3() {
        withAnimation(.bouncy(duration: 0.2)) {
        _onbStatus = .scene3
        }
    }
    
    enum OnbStatus {
        case scene0, scene1, scene2, scene3
    }
}
