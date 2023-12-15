//
//  BetWithStrangerView.swift
//  MinigamesMZ
//
//  Created by mnats on 27.11.2023.
//

import SwiftUI

struct BetWithStrangerView: View {
    @State private var flipped = false
    @State private var scaled = false
    @State private var animate3d = false
    @State private var isFinishPresented = false
    @State private var bet = 0
    @State private var deltaAngle: CGFloat = 0
    @State private var gameResult: GameResult = .draw
    var winChance = 0.5
    var completion = {}
    
    private func getLabel() -> String {
        if gameResult == .win {
            return "+\(bet)"
        } else if gameResult == .lose {
            return "-\(bet)"
        } else {
            return "Попробуем еще?"
        }
    }
    
    private func flip() {
        gameResult = winChance > Double.random(in: 0...1) ? .win : .lose
        deltaAngle = gameResult == .win ? 0 : 180
        Task {
            withAnimation(Animation.easeInOut(duration: 2)) {
                self.animate3d.toggle()
            }
            withAnimation(Animation.easeInOut(duration: 1)) {
                scaled.toggle()
            }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation(Animation.easeInOut(duration: 1)) {
                scaled.toggle()
            }
            
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation {
                isFinishPresented = true
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack() {
                    FrontCoin().opacity(flipped ? 0.0 : 1.0)
                    BackCoin().opacity(flipped ? 1.0 : 0.0)
                }
                .modifier(
                    FlipEffect(flipped: $flipped,
                               angle: animate3d ? 720 + deltaAngle : 0,
                               axis: (x: CGFloat.random(in: 0...1),
                                      y: CGFloat.random(in: 0...1)))
                )
                .scaleEffect(CGSize(width: scaled ? 1.5 : 1.0, height: scaled ? 1.5 : 1.0))
                .onTapGesture {
                    flip()
                }
                .padding(15)
            }
            
            if !isFinishPresented {
                VStack {
                    Text("Поставить")
                        .gameButtonStyle(.textBack)
                    
                    VStack {
                        ForEach([100, 250, 500], id: \.self) { amount in
                            Button(action: {
                                bet = amount
                                flip()
                            }, label: {
                                Text(amount.description)
                                    .gameButtonStyle( .nextButton)
                            })
                        }
                    }
                    .padding(.bottom, 6)
                }
            }  else {
                Text(getLabel())
                    .gameButtonStyle(.textBack)
                    .onAppear {
                        BalanceManager.shared.changeBalance(by: bet, gameResult: gameResult == .win ? .win : .lose)
                    }
                Text("Поставить еще?")
                    .gameButtonStyle(.textBack)
                
                VStack {
                    Button(action: {
                       isFinishPresented = false
//                        viewModel.buttonDisabled = false
                    }, label: {
                        Text("Да")
                            .gameButtonStyle( .nextButton)
                    })
                    Button(action: {
                        completion()
                    }, label: {
                        Text("Нет")
                            .gameButtonStyle( .nextButton)
                    })
                }
                .padding(.bottom, 6)
            }
            
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground(height: 0.5)
    }
}

struct FlipEffect: GeometryEffect {
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            self.flipped = Int(self.angle) % 360 >= 90 && Int(self.angle) % 360 < 270
        }
        
        let tweakedAngle = flipped ? -180 + angle : angle
        let a = CGFloat(Angle(degrees: tweakedAngle).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct FrontCoin : View {
    var body: some View {
        Image("coinPlus")
            .resizable()
            .frame(width: 150, height: 150)
    }
}

struct BackCoin : View {
    var body: some View {
        Image("coinMinus")
            .resizable()
            .frame(width: 150, height: 150)
    }
}
