//MARK: - UPD
import SwiftUI

struct MexicoHippodromView: View {
    
    @EnvironmentObject var mexicoHippodtromViewModel: MexicoHippodromViewModel
    var completion: () -> Void = {}
    
    var body: some View {
        VStack {
            switch mexicoHippodtromViewModel._gameStatus {
            case .chooseHorse:
                chooseHorseView()
            case .chooseSizeOfBet:
                chooseSizeOfBet()
            case .animation:
                animationView()
            case .result:
                resultView()
            }
        }
    }
    
    @ViewBuilder private func chooseHorseView() -> some View {
        Spacer()
        VStack {
            Text("Кто твой фаворит  сегодня: ")
                .gameButtonStyle(.textBack)
            
            ForEach(0..<4) { index in
                chooseHorseButtonView(index)
            }
            
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        
    }
    
    
    @ViewBuilder private func chooseHorseButtonView(_ index: Int) -> some View {
        Button(action: {
            mexicoHippodtromViewModel.selectedRate = mexicoHippodtromViewModel.horsesRate[index]
            mexicoHippodtromViewModel.setChooseSizeOfBet()
        }, label: {
            Text("\(mexicoHippodtromViewModel.horsesNames[index]) (\(mexicoHippodtromViewModel.horsesRate[index], specifier: "%.1f"))")
                .gameButtonStyle(.nextButton)
        })
    }
    
    
    @ViewBuilder private func chooseSizeOfBet() -> some View {
        
        VStack {
            Spacer()
            
            Text("Рзамер ставки: ")
                .gameButtonStyle(.textBack)
            
            ForEach(0..<4) { index in
                chooseSizeOfBetButtonView(index)
            }
            
        } 
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        
    }
    
    @ViewBuilder private func chooseSizeOfBetButtonView(_ index: Int) -> some View {
        Button(action: {
            mexicoHippodtromViewModel.selectedBetSize  = mexicoHippodtromViewModel.sizeOfBet[index]
            mexicoHippodtromViewModel.setAnimation()
        }, label: {
            Text("\(mexicoHippodtromViewModel.sizeOfBet[index])")
                .gameButtonStyle(.nextButton)
        })
    }
    
    
    
    @ViewBuilder private func animationView() -> some View {
        
        ZStack {
            Image("phonk")
 
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()

            
            
            VStack {
                Spacer()
                AnimatedHorseView()
                Spacer()
                AnimatedHorseView()
                Spacer()
                AnimatedHorseView()
                Spacer()
                AnimatedHorseView()
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    mexicoHippodtromViewModel.setResult()
                }
            }
        }
        
    }
    
    @ViewBuilder private func resultView() -> some View {
        let isWin = mexicoHippodtromViewModel.determineWine()
        
        VStack {
          Spacer()
            
            Text(isWin ? "С победой, хлопец" : "Деньги это лишь грязные зеленые бумажки избавляясь от них ты очищаешь свою душу, а я благородно забираю твой грех на себя. Можешь не благодарить")
                .gameButtonStyle(.textBack)
            
            Button {
                mexicoHippodtromViewModel.resetGame()
            } label: {
                Text("Ещё разок?")
                    .gameButtonStyle(.nextButton)
            }
            
            Button {
                completion()
            } label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
            } .padding(.bottom, 52)
            
        }
        .onAppear {
            BalanceManager.shared.changeBalance(by: isWin ? mexicoHippodtromViewModel.selectedBetSize * Int(mexicoHippodtromViewModel.selectedRate) : mexicoHippodtromViewModel.selectedBetSize, gameResult: isWin ? .win : .lose)
        }
        .frame(maxWidth: .infinity)
            .miniGameBackground()
        
    }
    
    
    
}


struct AnimatedHorseView: View {
    @State private var move = false
    @State private var speedMultiplier = Double.random(in: 0.2...0.5)
    
    var body: some View {
        Image("horse")
            .resizable()
            .frame(width: 80, height: 80)
            .offset(x: move ? UIScreen.main.bounds.width - 5 : -150)
        
            .animation (
                Animation.easeInOut(duration: Double.random(in: 1.5...2.6) / speedMultiplier), value: move
            )
            .onAppear {
                withAnimation {
                    self.move.toggle()
                }
            }
    }
}

//
//#Preview {
//    MexicoHippodromView().environmentObject(MexicoHippodromViewModel())
//}
