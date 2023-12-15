
import SwiftUI

struct SRPView: View {
    @EnvironmentObject var sprViewModel: SPRViewModel
    
    let myChoise = ["myP", "myR", "myS"]
    let enemyChoise = ["enP", "enR", "enS"]
    let wid = UIScreen.main.bounds.width * 0.4
    
    var completion = {}
    
    @ViewBuilder private func hands(leftHand: String, rightHand: String) -> some View {
        VStack  {
            HStack {
                Image(leftHand)
                    .resizable()
                    .frame(width: wid, height: wid)
                
                Spacer()
                
                Image(rightHand)
                    .resizable()
                    .frame(width: wid, height: wid)
            }
        }
        .padding(.bottom, 60)
    }
    
    var body: some View {
        VStack{
            switch sprViewModel._gameStatus {
            case .initial:
                initialView()
            case .animating:
                animatingView()
            case .result:
                resultView()
            case .endGame:
                endGameView()
            }
        }
    }
    
    @ViewBuilder private func initialView() -> some View {
        VStack {
            Spacer()
            hands(leftHand: myChoise.randomElement() ?? "myR", rightHand: enemyChoise.randomElement() ?? "enP")
            RPSGameTextView(text: "Чем играешь?", color: .textBack)
            
            VStack {
                RPSMainButtonView(text: "Камень") {
                    sprViewModel.playGame(with: .rock)
                }
                RPSMainButtonView(text: "Ножницы") {
                    sprViewModel.playGame(with: .scissors)
                }
                RPSMainButtonView(text: "Бумага") {
                    sprViewModel.playGame(with: .paper)
                }
            }
            .padding(.bottom, 60)
        }
        .miniGameBackground()
    }
    
    @ViewBuilder private func animatingView() -> some View {
        VStack {
            Spacer()
            HStack {
                AnimatedMyRockView()
                Spacer()
                AnimatedEnemyRockView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if sprViewModel.loses == 3 || sprViewModel.wins == 3  {
                        sprViewModel.setEndGame()
                    } else {
                        sprViewModel.setResult()
                    }
                }
            }
        }
        .miniGameBackground()
    }
    
    
    
    
    @ViewBuilder private func resultView() -> some View {
        VStack {
            Spacer()
            
            hands(leftHand: sprViewModel.playerChoice?.rawValue ?? "", rightHand: sprViewModel.computerChoice.rawValue)
            
            RPSGameTextView(text: sprViewModel.gameOutcome, color: .indigo)
                .padding(.bottom, 16)
            
            HStack {
                Text("Победы: \(sprViewModel.wins)")
                Spacer()
                Text("Поражения: \(sprViewModel.loses)")
            }
            .gameButtonStyle(.textBack)
            .padding(.bottom, 16)
            
            RPSMainButtonView(text: "Ещё разок") {
                sprViewModel.setInitial()
            }
            .padding(.bottom, 32)
            
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        
    }
    
    func endGameView() -> some View {
        
        VStack {
            Spacer()
            
            if sprViewModel.loses == 3 {
                RPSGameTextView(text: "В следующий раз повезёт, наверное...", color: .textBack)    .onAppear {
                    BalanceManager.shared.changeBalance(by: 150, gameResult: .lose)
                }
            } else if sprViewModel.wins == 3 {
                RPSGameTextView(text: "С победой, друг", color: .textBack)    .onAppear {
                    BalanceManager.shared.changeBalance(by: 150, gameResult: .win)
                }
            }
            
            RPSMainButtonView(text: "Ещё разок?") {
                sprViewModel.resetGame()
            }
            
            RPSMainButtonView(text: "Дальше") {
                completion()
            }.padding(.bottom, 52)
        }
    
        .padding(.bottom, 52)
        
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        
    }
}


//
//#Preview {
//    SRPView()
//        .environmentObject(SPRViewModel())
//}

struct RPSMainButtonView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text).gameButtonStyle(.nextButton)
        })
    }
}

struct RPSGameTextView: View {
    let text: String
    let color: Color
    var width: CGFloat? = nil
    var body: some View {
        Text(text).gameButtonStyle(color, width: width ?? UIScreen.main.bounds.width * 0.9)
    }
}

struct AnimatedMyRockView: View {
    @State private var moveUp = false
    
    var body: some View {
        
        Image("myR")
            .resizable()
            .frame(width: 100, height: 100)
            .offset(y: moveUp ? -70 : 70)
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
                    .speed(4.0),
                value: moveUp
            )
            .onAppear {
                self.moveUp.toggle()
            }
            .padding(.bottom, 60)
    }
}

struct AnimatedEnemyRockView: View {
    @State private var moveUp = false
    
    var body: some View {
        
        Image("enR")
            .resizable()
            .frame(width: 100, height: 100)
            .offset(y: moveUp ? -70 : 70)
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
                    .speed(4.0),
                value: moveUp
            )
            .onAppear {
                self.moveUp.toggle()
            }
            .padding(.bottom, 60)
    }
}
