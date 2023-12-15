import SwiftUI
//MARK: - UPD
struct UpdetedSportBettingView: View {
    
    @EnvironmentObject var updetedSportBettingViewModel: UpdetedSportBettingViewModel
    var completion: () -> Void = {}
    
    var body: some View {
        switch updetedSportBettingViewModel._gameStatus {
            
        case .firstQ:
            firstQView()
        case .secondQ:
            secondQView()
        case .chooseBet:
            chooseBetSizeView()
        case .animation:
            animatingView()
        case .result:
            resultView()
            
        }
    }
    
    
    @ViewBuilder private func questionButton(_ text: String, _ rate: Double, action: @escaping () -> Void) -> some View {
        
        Button(action: {
            updetedSportBettingViewModel.playerRate += rate
            action()
        }, label: {
            Text("\(text): \(rate, specifier: "%.1f")")
                .gameButtonStyle(.nextButton)
        })
        
    }
    
    @ViewBuilder private func firstQView() -> some View {
        VStack {
            Spacer()
            VStack {
                Text("На ближайшем матче будет четное число зрителей?")
                    .gameButtonStyle(.textBack)
                
                questionButton("Да", updetedSportBettingViewModel.rate[0]) {
                    updetedSportBettingViewModel.setChooseSecondQ()
                }
                questionButton("Нет", updetedSportBettingViewModel.rate[1]) {
                    updetedSportBettingViewModel.setChooseSecondQ()
                } .padding(.bottom, 32)
                
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
    
    @ViewBuilder private func secondQView()  -> some View {
        
        VStack {
            Spacer()
            VStack {
                Text("Кто сделает больше замен?")
                    .gameButtonStyle(.textBack)
                
                questionButton("Хозяева", updetedSportBettingViewModel.rate[2]) {
                    updetedSportBettingViewModel.setChooseBet()
                }
                questionButton("Гости", updetedSportBettingViewModel.rate[3]) {
                    updetedSportBettingViewModel.setChooseBet()
                } .padding(.bottom, 32)
                
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
        
    }
    
    @ViewBuilder private func chooseSizeBetButton(_ sizeBet: Int) -> some View {
        Button(action: {
            updetedSportBettingViewModel.playerBetSize = updetedSportBettingViewModel.sizeBet[sizeBet]
            updetedSportBettingViewModel.setAnimation()
        }, label: {
            Text("\(updetedSportBettingViewModel.sizeBet[sizeBet])")
                .gameButtonStyle(.nextButton)
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
                .padding(.bottom, 24)
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
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)  {
                    updetedSportBettingViewModel.setResult()
                }
            }
    }
    
    @ViewBuilder private func resultViewButton(_ text: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text("\(text)")
                .gameButtonStyle(.nextButton)
        })
    }
    
    @ViewBuilder private func resultView() -> some View {
        let isWin = updetedSportBettingViewModel.determineWin()
        
        VStack {
            Spacer()
            Text(isWin ? "С Детства за них болею!! И Сына научу!" : "Кривоногие бездари...")
                .gameButtonStyle(.textBack)
            
            resultViewButton("Ладно, давай ещё разок") {
                updetedSportBettingViewModel.setChooseFirstQ()
            }
            resultViewButton("Дальше") {
                completion()
            } .padding(.bottom, 32)
            
        }
        .padding(.bottom, 32)
        .onAppear {
            BalanceManager.shared.changeBalance(by: isWin ? updetedSportBettingViewModel.playerBetSize * Int(updetedSportBettingViewModel.playerRate) : updetedSportBettingViewModel.playerBetSize, gameResult: isWin ? .win : .lose)
        }
        .frame(maxWidth: .infinity)
        .miniGameBackground()
    }
    
}

//#Preview {
//    UpdetedSportBettingView().environmentObject(UpdetedSportBettingViewModel())
//}
