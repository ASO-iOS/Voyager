//
//  GameStateRoute.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

protocol NavHost {}

struct RouteStack<V: NavHost> {
    var routes: [V] = []
    
    mutating func push(_ s: V) {
        self.routes.append(s)
    }
    
    mutating func pop() {
        _ = self.routes.popLast()
    }
    
    mutating func popToRoot() {
        self.routes.removeAll()
    }
    
    func top() -> V? {
        return self.routes.last
    }
}

class NavRouter<V: NavHost>: ObservableObject {
    @Published var route: V?
    
    @Published var direction: NavDirection = .forward
    
    private let duration = 0.2
    
    var routeStack = RouteStack<V>() {
        didSet { self.route = routeStack.top() }
    }
    
    init(route: V?) {
        self.route = route
    }
    
    func push(route: V) {
        withAnimation(.smooth(duration: duration)) {
            direction = .forward
            routeStack.push(route)
        }
        
    }
    
    func pop() {
        
        withAnimation(.smooth(duration: duration)) {
            direction = .backward
            routeStack.pop()
        }
    }
    
    func popToRoot() {
        
        withAnimation(.linear(duration: duration)) {
            direction = .backward
            routeStack.popToRoot()
        }
    }
    
    enum NavDirection {
        case forward, backward
    }
}



