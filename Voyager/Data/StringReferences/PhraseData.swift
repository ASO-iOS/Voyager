//
//  DialogTwoAnswersData.swift
//  Voyager
//
//  Created by admin on 28.11.2023.
//

import Foundation

struct PhraseData {
    let text: String
    let type: PhraseType
    var answerPositive: String? = nil
    var answerNegative: String? = nil
    var answerNeutral: String? = nil
    var hasAnswers: Bool = false
}

enum PhraseType: String, CaseIterable {
    case common, mc, casinoPartner, sportsman, grandma, bartender, exSectarian, exFellowStudent, investMan, hippodromeMan, cryptoMan, thimblesMan, students, wealthyWoman, homelessMan, randomGuy, dem, mrn
    
    var imageName: String {
        switch self {
        case .common:
            return ""
        case .mc:
            return "mc"
        case .casinoPartner:
            return "casinoPartner"
        case .sportsman:
            return "sportsman"
        case .grandma:
            return "grandma"
        case .bartender:
            return "bartender"
        case .exSectarian:
            return "exSectarian"
        case .exFellowStudent:
            return "exFellowStudent"
        case .investMan:
            return "investMan"
        case .hippodromeMan:
            return "hippodromeMan"
        case .cryptoMan:
            return "cryptoMan"
        case .thimblesMan:
            return "thimblesMan"
        case .students:
            return "students"
        case .wealthyWoman:
            return "wealthyWoman"
        case .homelessMan:
            return "homelessMan"
        case .randomGuy:
            return "randomGuy"
        case .dem:
            return ["dem0", "dem1", "dem2", "dem3", "dem4"].randomElement() ?? "dem0"
        case .mrn:
            return "mrn"
        }
    }
}

