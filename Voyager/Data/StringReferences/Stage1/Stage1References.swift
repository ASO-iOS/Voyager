//
//  Stage1Preview.swift
//  Voyager
//
//  Created by admin on 28.11.2023.
//

import Foundation

struct Stage1PreviewReference: PhraseDelegate {
    
    static let shared = Stage1PreviewReference()
    private init() {}
    
    private let text0 = PhraseData(
        text: "Голова соображает так плохо, что ты с трудом отличаешь туман в глазах от тумана поверх мокрой улицы. У тебя в карманах слегка помятые документы с твоими фото и именем, которое ни о чём не говорит и никак не кажется своим. Нет ни телефона, ни денег, ни ключей от какой-либо двери. Тебя мучает жажда и голод. Хочешь жить – умей вертеться, даже если вместо вращений у тебя лишь ходьба по асфальту навстречу судьбе.",
        type: .common
    )
    
    
    var phrases: [PhraseData] {
        return [text0]
    }
}

struct Stage1ThimblesReference: PhraseDelegate {
    static let shared = Stage1ThimblesReference()
    private init() {}
    
    private let text0 = PhraseData(
        text: "Если всё потеряно, а выживать как-то нужно, остаётся последнее средство – пойти на преступление. Только вот у тебя в карманах нет никакого оружия, без которого ты не знаешь, как можно забрать чужое. Остаются два варианта, и неясно, что из них хуже: просить милостыню, или… пойти на риск.",
        type: .common
    )
    
    private let text1 = PhraseData(
        text: "Так ты думал, глядя на ловкача-напёрсточника прямо у подворотни. Он умело собирал одях вокруг себя, завораживая их быстрыми движениями рук, что стремились запутать всех окружающих с целью наживы. Говорил он совершенно обычно, но неустанно: “Кручу-верчу, запутать хочу!”.",
        type: .common
    )
    
    private let text2 = PhraseData(
        text: "- Эй, ты, хочешь попробовать?",
        type: .thimblesMan
    )
    
    private let text3 = PhraseData(
        text: "- Не особо, мне играть совсем не на что.",
        type: .mc
    )
    
    private let text4 = PhraseData(
        text: "- Да ну, все так говорят, а ты начни с монетки, а дальше пойдёт-поедет…",
        type: .thimblesMan
    )
    
    private let text5 = PhraseData(
        text: "- Ты не понял? У меня пустые карманы. Лучше бы я продал твои напёрстки и купил на них хлеба, но я слишком слаб, чтобы отобрать у тебя что-то силой…",
        type: .mc
    )
    
    private let text6 = PhraseData(
        text: "- Ну-ка, ну-ка, угрожает он! Драться вздумал – бог накажет! Вон, я вижу, у тебя огромный серебрянный крест на цепочке, давай ставь его, раз тебе играть больше не на что.",
        type: .thimblesMan,
        answerPositive: "Поставить крест",
        answerNegative: "Не ставить крест",
        hasAnswers: true
    )
    
    private let text7 = PhraseData(
        text: "",
        type: .thimblesMan,
        answerPositive: "- Да, я вижу, ты настроен серьёзно. Но теперь мы сыграем как следует, на сумму по-больше!",
        answerNegative: "- Тут ты прав, есть вещи, что важнее любого азарта. У каждого есть то, что в прямом смысле свято. Вижу, ты всё правильно думаешь, так что я, так и быть, дам тебе сыграть один раз бесплатно!",
        hasAnswers: true
    )
    
    
    private let textSide0 = PhraseData(
        text: "Положительный ход игры затянул до такой степени, что ты совсем перестал смотреть по сторонам. Сбить фокус удалось девушке в одеянии кричащего цвета. Провожая её глазами, ты заметил, что, когда она не глядя взялась вынимать свой длинный телефон из сумочки, что-то плоское зацепилось и бесшумно упало.",
        type: .common
    )
    
    private let textSide1 = PhraseData(
        text: "Это был винтажный бумажник с купюрами без отделений под карты банков. Был велик соблазн забрать всё себе и вложить в игровой оборот, чтобы заработать не только “на поесть” на сегодня. Оставался вариант догнать незнакомку и рыцарски вернуть ей пропажу. Догнать её совершенно не сложно, но вот, всё таки, стоит ли…",
        type: .common
    )
    
    private let textSide2 = PhraseData(
        text: "Как поступить?",
        type: .common,
        answerPositive: "Вернуть кошелек.",
        answerNegative: "Забрать себе.",
        answerNeutral: "Игра важнее всего! Бездействовать.",
        hasAnswers: true
    )

    
    private let textSideNegative = PhraseData(
        text: "Кричащий внешний вид девушки не так ослеплял тебя, как потребность насытиться хотя бы какой-нибудь пищей. По внешнему виду прохожей было понятно, что денег у неё на всё более чем достаточно, чего нельзя сказать о тебе. Так что ты присвоил находку, получив все вложения.",
        type: .common
    )
    
    
    private let textSideNeutral = PhraseData(
        text: "Ты решил, что нельзя отходить от игры, пока тебе так везёт. Догнать даму, чтобы отдать бумажник, или нагло присвоить его себе – пусть это решает кто-нибудь другой, кто-нибудь из проигравшихся, находящихся рядом теперь без дела.",
        type: .common
    )
    
    private let textSidePositive0 = PhraseData(
        text: "- Здравствуйте, я не даю милостыню.",
        type: .wealthyWoman
    )
    private let textSidePositive1 = PhraseData(
        text: "- Я и не прошу. Вот ваш кошелёк, не теряйте больше, будьте аккуратны.",
        type: .mc
    )
    private let textSidePositive2 = PhraseData(
        text: "- А-ха-ха, и я в это должна поверить? Вы украли мой бумажник и пытались затеряться в толпе таких же бездомных, но совесть не дала вам покоя. И теперь вы решили снять с себя подозрение, выдумав эту легенду.",
        type: .wealthyWoman
    )
    private let textSidePositive3 = PhraseData(
        text: "- Полагаю, мне смысла нет что-либо доказывать. Раз уж вы решили, что я покаялся, прошу не писать на меня заявление.",
        type: .mc
    )
    private let textSidePositive4 = PhraseData(
        text: "- Да будет вам, я же просто подначиваю. Я вам верю, спасибо за находку. Вот вам приз, всё равно эти купюры уже совсем ветхие.",
        type: .wealthyWoman
    )
    
    var phrases: [PhraseData] {
        return [text0, text1, text2, text3, text4, text5, text6, text7, textSide0, textSide1, textSide2, textSideNegative, textSideNeutral, textSidePositive0, textSidePositive1, textSidePositive2, textSidePositive3, textSidePositive4]
    }
}

//import Foundation
//import SwiftUI

import Foundation

struct Stage1LotteryReference: PhraseDelegate {
    
    static let shared = Stage1LotteryReference()
    private init() {}
    
    private let text0 = PhraseData(
        text: "Ты освоился так здорово, что не заметил, как за окружающей пьяню начали стягиваться машины из вытрезвителя, вместе с полицейским сопровождением. Полицейские быстро поняли, чего ради тут все собираются, так что твой друг-напёрсточник побросал всё, что можно, и пустился в бега при виде погон. Оставаться здесь было опасно, от таких облав не спасёт и твой крест размером со столб.",
        type: .common
    )
    
    private let text1 = PhraseData(
        text: "Так ты думал, сторонясь алконавтов и двигаясь в сторону обычных прохожих, неподозрительных и непримечательных.",
        type: .common
    )
    
    private let text2 = PhraseData(
        text: "У тебя на руках теперь было немного денег, самое время подкрепиться, раз уж спешить сейчас некуда. В ресторан ты вряд ли войдёшь в таком виде, а вот подойти к ларьку рядом с рюмочной или к привокзальной пекарне – самое то. Шаурма, пирог, ватрушка, чай – еда мучная, выручай!",
        type: .common
    )
    
    private let text3 = PhraseData(
        text: "В союзе печати неподалёку виднеются огромные марки, распечатанные листами. При ближайшем рассмотрении оказывается, что это лотерейные билеты. Билет стоит всего червонец. Выглядит ярко, бликует и манит. Раз уж повезло с шулером из подворотни, может, и тут шансы есть?",
        type: .common
    )
    
    private let textSide0 = PhraseData(
        text: "На подходах к светящимся ларёчкам ты заметил сидящего на широкой картонке поверх асфальта. Он производил впечатление обессилевшего до такой степени человека, что едва мог поднять руки.",
        type: .homelessMan
    )
    
    private let textSide1 = PhraseData(
        text: "Он заметил твоё внимание и ответил просящим взглядом обречённого на голодную смерть. Очевидно, что в таком случае он был бы рад любой помощи, и ты мог бы помочь даже куском хлеба, но вот стоило ли разбазариваться на это, если ещё в начале дня ты сам был в его положении?",
        type: .homelessMan
    )
    
    private let textSide2 = PhraseData(
        text: "Как поступишь?",
        type: .homelessMan,
        answerPositive: "Помочь",
        answerNegative: "Я что похож на благотворителя?",
        answerNeutral: "Пройти мимо",
        hasAnswers: true
    )
    
    private let textSidePositive = PhraseData(
        text: "Сострадание победило, ты решил купить ему буханку ржаного с маленькой бутылкой воды. Счастью не было предела, однако сильно долго радоваться твой новый друг не стал, так как есть хотелось уж слишком сильно.",
        type: .homelessMan
    )
    
    private let textSideNeutral = PhraseData(
        text: "Разве можно помочь всем на свете? Тебя сейчас просто не до того. Обязательно поможешь кому-нибудь, как станешь богатым и свободным от экстремального выживания – так думал ты, проходя мимо, сохраняя нейтралитет и безучастность.",
        type: .homelessMan
    )
    
    private let textSideNegative0 = PhraseData(
        text: "Почему кто-то должен получать всё бесплатно, пока ты карабкаешься с самого дна? Так ты думал, отвечая попрошайке, что за бездействие он ничего не получит – ни еды, ни воды, ни работы, ни сострадания.",
        type: .common
    )
    
    private let textSideNegative1 = PhraseData(
        text: "Вопреки ожиданиям, он ответил, что у него всё это уже было. Он пытался наполнить жизнь благами и смыслом за счёт своего труда, но, когда успех уже начал приносить плоды, его бизнес отняли рейдеры, а его документы сожгли.",
        type: .homelessMan
    )
    
    private let textSideNegative2 = PhraseData(
        text: "Так что теперь он поддерживался на плаву исключительно по воле случая, в зависимости от того, сколько добрых людей он повстречает за день. Он решил, что вы похожи, но, по всей видимости, он ошибся.",
        type: .homelessMan
    )
    
    private let textSideNegative3 = PhraseData(
        text: "Ты ведь тоже был на грани гибели, и тебе тоже помогла зацепиться воля случая. Но вот стоило ли разбазаривать полученный кредит судьбы на себе подобных? Сложно было засыпать с такими мыслями в голове,.. по крайней мере первые несколько раз.",
        type: .common
    )
    
    
    var phrases: [PhraseData] {
        return [text0, text1, text2, text3, textSide0, textSide1, textSide2, textSidePositive, textSideNeutral, textSideNegative0, textSideNegative1, textSideNegative2, textSideNegative3]
    }
}

struct Stage1RPSReference: PhraseDelegate {
    
    static let shared = Stage1RPSReference()
    private init() {}
    
    private let text0 = PhraseData(
        text: "Проходя мимо небольших магазинчиков с едой и лимонадами ты заметил группу подростков, которые бьют кулаками перед собой по невидимому столу. Позже стало ясно, что они разыгрываются на камень-ножницы-бумага, вот только для чего им это понадобилось?",
        type: .common
    )
    
    private let text1 = PhraseData(
        text: "- Дядь, а дядь,.. - обратился один из них.",
        type: .students
    )
    
    private let text2 = PhraseData(
        text: "- Да, чего?",
        type: .mc
    )
    
    private let text3 = PhraseData(
        text: "- Мы студенты первокурсники, вот нам стипендию выдали, мы решили взять по пиву, но продавать нам никто не станет, потому что мы на год младше нужного возраста, ведь все пошли  в школу с 6ти лет. Посветить паспортом не получится, может быть, вы возьмёте нам по банке питья? За труды мы накинем немного сверху.",
        type: .students
    )
    
    private let text4 = PhraseData(
        text: "- Без проблем, ребят, только предлагаю другой вариант. Я тут видел, вы разыгрывались на КМН. Мы можем сыграть с любым из вас на червонцы или полтинники, в этих пределах. Баночки я вам куплю и так, бесплатно, попробуйте на остаток суммы лучше сыграть и выиграть себе ещё на закусь, допустим. Если проиграете, потеря не велика, вы всё равно хотели мне эти деньги отдать. Ну, что скажете?",
        type: .mc
    )
    
    private let text5 = PhraseData(
        text: "- Да, дядь, вам только в казино и работать, разводить на рулетку. Ну давайте, раз уж мы ничего не теряем, только отойдём в сторонку и отопьём понемногу сперва, хорошо?",
        type: .students
    )
    
    private let text6 = PhraseData(
        text: "- Без проблем, погнали.",
        type: .mc
    )
    
    var phrases: [PhraseData] {
        return [text0, text1, text2, text3, text4, text5, text6]
    }
}

struct Stage1StrangerArgumentReference: PhraseDelegate {
    
    static let shared = Stage1StrangerArgumentReference()
    private init() {}
    
    private let text0 = PhraseData(
        text: "Шла игра, веселье шло – всем там было хорошо. Так могли сидеть весь вечер, но ты кем-то был замечен.",
        type: .common
    )
    
    private let text1 = PhraseData(
        text: "- Извините, а что это у вас тут, собственно говоря, происходит? Мужчина, вы чего к молодым пристаёте? Навязали им какие-то игры полублатные – вы чему это учите молодёжь?",
        type: .hippodromeMan
    )
    
    private let text2 = PhraseData(
        text: "- Я учу их полагаться на шанс лишь тогда, когда это часть досуга и отдыха. Я не обещал им, что они здесь накопят на АААВТОМОБИИИЛЬ. И вообще, вам то какое дело и что это за расспросы?",
        type: .mc
    )
    
    private let text3 = PhraseData(
        text: "- А такое, что я их преподаватель из университета. Эти оборванцы так “внимательно” посещали мои занятия, что даже не успели запомнить, каков я на внешний вид. Сомневаюсь, что они дотянут до сессии, раз у них вместо уравнений пивное веселье по вечерам.",
        type: .hippodromeMan
    )
    
    private let text4 = PhraseData(
        text: "- Не согласен. Нужно уметь работать, это бесспорно, но нужно уметь и отдыхать, иначе сил на работу не будет. Предлагаю вот что: мы сейчас заканчиваем нашу азартную встречу, всех расходятся восвояси, но позже мы с вами посмотрим, как ребята справятся с сессией. Если у них вновь всё будет ровно, как и до этого, я выигрываю спор, если не зачтутся – вы выигрываете. Проверим, кто прав. В случае победы я получаю от вас шпаргалку по теории вероятности, чтобы ставки всякие делать и выигрывать. В случае поражения я больше не подойду к студентам с любыми азартными играми. Вы согласны?",
        type: .mc
    )
    
    private let text5 = PhraseData(
        text: "- Согласен, конечно, надо же это как-то прекращать. А шпаргалок у меня вагон, с этим проблем не будет.",
        type: .hippodromeMan
    )
    
    var phrases: [PhraseData] {
        return [text0, text1, text2, text3, text4, text5]
    }
}
