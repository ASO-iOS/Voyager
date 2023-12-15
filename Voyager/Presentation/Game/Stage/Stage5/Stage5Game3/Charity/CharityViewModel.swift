//
//  CharityViewModel.swift
//  Voyager
//
//  Created by admin on 14.12.2023.
//

import SwiftUI

final class CharityViewModel: ObservableObject {
    @Published private(set) var state: CharityState = .selectShesterka
    
    @Published var amount = 0
    var charityArray = [
        CharityData(
            name: "Начинающий футболист",
            profitDescription: "Футболист оказался очень талантливым, после перехода в известный футбольный клуб, он решил отблагодарить вас",
            failureDescription: "Футболист оказывается раздолбаем и спивается с первых заработанных гонораров, растрачивая физическую форму",
            profitPercentage: 40
        ),
        CharityData(
            name: "Скрипачка",
            profitDescription: "Переехав в швейцарию и начав карьеру, молодая скрипачка поражает всех своей игрой, вы молодец!",
            failureDescription: "Скрипка, которую вы купили, была обменяна на недопитый стакан сока, скрипачка оказалась не очень смышленой",
            profitPercentage: 51
        ),
        CharityData(
            name: "Нищий химик",
            profitDescription: "Химик выигрывает сразу несколько грантов, он обеспечен до конца жизни, вам тоже немного перепало",
            failureDescription: "Как оказалось, никому не нужна зубная паста, от которой растут ногти на ногах...",
            profitPercentage: 62
        ),
        CharityData(
            name: "Мать восьми детей",
            profitDescription: "Один из ее сыновей оказался талантливым композитором...",
            failureDescription: "Бывают же на свете не честные люди, вас просто обманули, а детей то никаких и нет...",
            profitPercentage: 6
        ),
        CharityData(
            name: "Немой певец",
            profitDescription: "Скорее всего это не возможно, но немой певец очень красиво поет, его талант по достоинству оценили в Немеции",
            failureDescription: "А чего вы ожидали?...",
            profitPercentage: 12
        ),
        CharityData(
            name: "Энтомолог в Австралии",
            profitDescription: "В Австралии очень много жучков - паучков, вы не прогадали",
            failureDescription: "Энтомолог оказался не слишком образованным, перепутал жучка с паучком и отравился",
            profitPercentage: 38
        ),
        CharityData(
            name: "Экзорцист",
            profitDescription: "Очень выгодная профессия, вокруг столько демонов!",
            failureDescription: "Как оказалось, демонов не существует",
            profitPercentage: 47
        ),
        CharityData(
            name: "Любовь",
            profitDescription: "Гарвард принял вашу оплату любовью, поздравляем!",
            failureDescription: "Почему то Гравард не принял вашу оплату любовью",
            profitPercentage: 29
        ),
        CharityData(
            name: "Слепой художник",
            profitDescription: "Талант можно проявлять даже с закрытыми глазами!",
            failureDescription: "Ну как сказать, тут все было понятно заранее...",
            profitPercentage: 34
        ),
        CharityData(
            name: "Глухой диджей",
            profitDescription: "Вполне сносную музыку пишет этот гений!",
            failureDescription: "У вас пошла кровь из ушей уже после первой композиции",
            profitPercentage: 55
        )
    ].shuffled()
    
    let amountArray = [1000, 2000, 5000, 10000]
    
    enum CharityState {
        case selectShesterka
        case selectAmount
        case loading
        case result
    }
    
    enum CharityResultState {
        case profit, failure
    }
    
    func resetGame() {
        amount = 0
        charityArray = charityArray.shuffled()
        state = .selectShesterka
    }
    
    func setSelectAmount() {
        state = .selectAmount
    }
    
    func setLoading() {
        state = .loading
    }
    
    func setResult() {
        state = .result
    }
    
//    func start() {
//        DispatchQueue.main.asyncAfter(deadline: <#T##DispatchTime#>, execute: <#T##DispatchWorkItem#>)
//    }
    
    func getResult() {
        
    }
    
    struct CharityResult {
        let result: CharityResultState
        let winnings: Int
    }
    
    struct CharityData {
        let name: String
        let profitDescription: String
        let failureDescription: String
        let profitPercentage: Int
    }
    
//    struct CharityDataDescription {
//        var description: String
//        var resultText: String
//    }
//
//    struct CharityData {
//        var name: String
//        var profitDescription: CharityDataDescription
//        var failureDescription: CharityDataDescription
//        var profitPercentage: Int
//    }
}

