//
//  OnboardingView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var onbViewModel: OnboardingViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    
    var body: some View {
        ZStack {
            Image("backPreview")
                .resizable()
                .ignoresSafeArea(.all)
            
            if onbViewModel._onbStatus != .scene0 {
                Image("mc")
                    .resizable()
                    .scaledToFit()
            }

        }
        
        VStack {
            switch onbViewModel._onbStatus {
            case .scene0:
                scene0View()
            case .scene1:
                scene1View()
            case .scene2:
                scene2View()
            case .scene3:
                scene3View()
            }
        }
//        .transition(.move(edge: .trailing))
    }
    
    
    @ViewBuilder private func scene0View() -> some View {
//        ZStack {
//            Image("back")
//            Image("previewBack")
//                .resizable()
//                .opacity(0.9)
            
            VStack {
                Image ("preview")
                    .onAppear(perform: {
                        nextStep()
                    })
            }
//        }
    }
    
    private func nextStep() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            onbViewModel.setScene1()
        }
    }
    
    @ViewBuilder private func scene1View() -> some View {
//        ZStack {
//            Image("back")
//            Image("previewBack")
//                .resizable()
//                .opacity(0.9)

            
            VStack {
                Spacer()
                
                Text("Игра, в которую Вам сейчас доведется поиграть, была бы номинирована на игру года и без труда забрала бы этот титул, но наша команда уважает создателей BG3 и мы решили выпустить наше творение чуть позже, что бы не забирать у них лавры чемпионов.")
                    .gameTextStyle(.textBack)
                
                
                
                
                
                Button(action: onbViewModel.setScene2, label: {
                    Text("Дальше")
                        .gameButtonStyle(.nextButton)
                })
                
                
                Button(action: {
                    appRouter.push(route: .main)
                    StorageManager.shared.toggleOnboarding()
                }, label: {
                    Text("Пропустить")
                        .gameButtonStyle(.textBack)
                })
                .padding(.bottom, 150)
                
                
                
                
            }
            
//        }
    }
    
    @ViewBuilder private func scene2View() -> some View {
//        ZStack {
//            Image("back")
//            Image("previewBack")
//                .resizable()
//                .opacity(0.9)
//            Image("mc")
//                .resizable()
//                .scaledToFit()
            
            VStack {
                
                Spacer()
                
                Text("Наше творение, поведает Вам историю жизни человека оказавшегося в трудной жизненной ситуации и пытающигося справится со всеми проблемами возникающими у него на пути \n P.S.  Все трюки выполнены профессианалами поэтому повторять этот тернистый путь мы не рекомендуем никому \n P.S.S. Вообще никому")
                    .gameTextStyle(.textBack)
                
                
                
                Button(action: onbViewModel.setScene3, label: {
                    Text("Дальше")
                        .gameButtonStyle(.nextButton)
                })
                
                
                Button(action: {
                    appRouter.push(route: .main)
                    StorageManager.shared.toggleOnboarding()
                }, label: {
                    Text("Пропустить")
                        .gameButtonStyle(.textBack)
                })
                .padding(.bottom, 150)
                
                
                
            }
            
//        }
    }
    
    @ViewBuilder private func scene3View() -> some View {
//        ZStack {
//            Image("back")
//            Image("previewBack")
//                .resizable()
//                .opacity(0.9)
//            Image("mc")
//                .resizable()
//                .scaledToFit()
            
            VStack {
                
                Spacer()
                
                Text("И как говорил мой учитель по георграфии Вениамин Елистратович: \"Тайвань часть Китая! Запомните вы уже это!!!")
                    .gameTextStyle(.textBack)
                
                
                Button(action: {
                    appRouter.push(route: .main)
                    StorageManager.shared.toggleOnboarding()
                }, label: {
                    Text("Ну че народ? Погнали?")
                        .gameButtonStyle(.nextButton)
                })
                
                .padding(.bottom, 150)
                
                
                
            }
            
//        }
    }
}

//#Preview {
//    OnboardingView()
//}
