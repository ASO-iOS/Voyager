import SwiftUI

struct OriginalSportBettingView: View {
    
    @EnvironmentObject var originalSportBettingViewModel: OriginalSportBettingViewModel
    var completion = {}
    
    var body: some View {
        VStack {
            switch originalSportBettingViewModel._gameStatus {
            case .chooseTeam:
                chooseTeamView()
            case .chooseBet:
                chooseBetSizeView()
            case .animation:
                animatingView()
            case .result:
                resultView()
            }
        }
    }
    
    @ViewBuilder private func chooseTeamButton(_ rate: Int) -> some View {
        
        Button(action: {
            originalSportBettingViewModel.playerRate = originalSportBettingViewModel.winRate[rate]
            originalSportBettingViewModel.setChooseBet()
        }, label: {
            Text("\(originalSportBettingViewModel.teamsArray[rate]): \(originalSportBettingViewModel.winRate[rate], specifier: "%.1f")")
                .gameButtonStyle(.nextButton)
//                .foregroundColor(.white)
//                .font(.headline)
//                .padding()
//                .frame(maxWidth: 280)
//                .background(Color.orange.opacity(1))
//                .border(Color.black, width: 2)
        })
        
    }
    
    
    @ViewBuilder private func chooseTeamView() -> some View {
        VStack {
            Spacer()
            VStack {
                Text("Кто выиграет-то?")
                    .gameButtonStyle(.textBack)
                
                
                chooseTeamButton(0)
                
                Button(action: {
                    originalSportBettingViewModel.playerRate = originalSportBettingViewModel.drawRate[0]
                    originalSportBettingViewModel.setChooseBet()
                }, label: {
                    Text("Ничья: \(originalSportBettingViewModel.drawRate[0], specifier: "%.1f")")
                        .gameButtonStyle(.nextButton)
                })
                chooseTeamButton(1)
                
//                Button(action: {
//                    originalSportBettingViewModel.playerRate = originalSportBettingViewModel.winRate[1]
//                    originalSportBettingViewModel.setChooseBet()
//                }, label: {
//                    Text("\(originalSportBettingViewModel.teamsArray[1]): \(originalSportBettingViewModel.winRate[1], specifier: "%.1f")")
//                        .gameButtonStyle(.nextButton)
//                })
            } .padding(.bottom, 32)
        } .frame(maxWidth: .infinity)
            .background {
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .frame(height: 5)
                        Rectangle()
                            .foregroundStyle(Color(red: 0.13, green: 0.14, blue: 0.19))
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                    }
                }.ignoresSafeArea()
            }
    }
    
    
    @ViewBuilder private func chooseSizeBetButton(_ sizeBet: Int) -> some View {
        Button(action: {
            originalSportBettingViewModel.playerBetSize = originalSportBettingViewModel.sizeBet[sizeBet]
            originalSportBettingViewModel.setAnimation()
        }, label: {
            Text("\(originalSportBettingViewModel.sizeBet[sizeBet])")
                .gameButtonStyle(.nextButton)
//                .foregroundColor(.white)
//                .font(.headline)
//                .padding()
//                .frame(maxWidth: 280)
//                .background(Color.orange.opacity(1))
//                .border(Color.black, width: 2)
        })
    }
    
    @ViewBuilder private func chooseBetSizeView() -> some View {
        VStack {
            Spacer()
            VStack {
                Text("Сколько ставим, друг?")
                    .gameButtonStyle(.textBack)
                
                chooseSizeBetButton(0)
                chooseSizeBetButton(1)
                chooseSizeBetButton(2)
                    .padding(.bottom, 32)
                
            }
        } 
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
    
    @ViewBuilder private func animatingView() -> some View {
        VStack {
            Spacer()
            Text("Здесь в моих планах была красивая анимация полета мяча и забития голов, но мне просто не хватило денег что бы оплатить этот труд нашего дизайнера Никиты, поэтому я написал текст который вы все равно не прочтете за 1,5 секунды ))))")
                .gameButtonStyle(.textBack)
                .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)  {
                originalSportBettingViewModel.setResult()
            }
        }
    }
    
    @ViewBuilder private func resultView() -> some View {
        let isWin = originalSportBettingViewModel.determineWin()
        
        VStack {
            Spacer()
            Text(isWin ? "С Детства за них болею!! И Сына научу!" : "Кривоногие бездари...")
                .gameButtonStyle(.textBack)
            
            Button(action: {
                originalSportBettingViewModel.resetGame()
            }, label: {
                Text("Ладно, давай ещё разок")
                    .gameButtonStyle(.nextButton)
            })
            
            Button(action: {
                completion()
            }, label: {
                Text("Дальше")
                    .gameButtonStyle(.nextButton)
            }) 
            .padding(.bottom, 32)
        }
        .padding(.bottom, 32)
        .onAppear {
            BalanceManager.shared.changeBalance(
                by: isWin ? originalSportBettingViewModel.playerBetSize * Int(originalSportBettingViewModel.playerRate) :
                    originalSportBettingViewModel.playerBetSize,
                gameResult: isWin ? .win : .lose
            )
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
    
}
