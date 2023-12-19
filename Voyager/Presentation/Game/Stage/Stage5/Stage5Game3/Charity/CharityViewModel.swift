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
            profitDescription: CharityDataDescription(
                description: "Как из комикса вышел, он прыгает, словно супергерой, забивает мячи с закрытыми глазами. Его футболка стала талисманом удачи для клуба.",
                resultText: "Футболист оказался очень талантливым, после перехода в известный футбольный клуб, он решил отблагодарить вас"),
            failureDescription: CharityDataDescription(
                description: "Талант в руках этого футболиста превратился в бесконечный карнавал, где мяч заменён на пивную бутылку, а стадион – на бар.",
                resultText: "Футболист оказывается раздолбаем и спивается с первых заработанных гонораров, растрачивая физическую форму"),
            profitPercentage: 40
        ),
        CharityData(
            name: "Скрипачка",
            profitDescription: CharityDataDescription(
                description:  "С каждой нотой она ворует души слушателей, её скрипка звучит как голос ангела, который случайно научился играть на скрипке.",
                resultText: "Переехав в швейцарию и начав карьеру, молодая скрипачка поражает всех своей игрой, вы молодец!"),
            failureDescription: CharityDataDescription(
                description: "Сага о скрипке, превратившейся в соковыжималку, ведёт нас в мир, где музыкальный инструмент становится жертвой непонимания искусства.",
                resultText: "Скрипка, которую вы купили, была обменяна на недопитый стакан сока, скрипачка оказалась не очень смышленой"),
            profitPercentage: 51
        ),
        CharityData(
            name: "Нищий химик",
            profitDescription: CharityDataDescription(
                description: "Он смешивает химикаты, как волшебник, создавая чудеса в пробирках. Его творения - золотые билеты в мир науки и богатства.",
                resultText: "Химик выигрывает сразу несколько грантов, он обеспечен до конца жизни, вам тоже немного перепало"),
            failureDescription: CharityDataDescription(
                description:  "Ногти на ногах растут, как в фантастическом фильме, но к сожалению, этот химический трюк не нашёл своих поклонников.",
                resultText: "Как оказалось, никому не нужна зубная паста, от которой растут ногти на ногах..."),
            profitPercentage: 62
        ),
        CharityData(
            name: "Мать восьми детей",
            profitDescription: CharityDataDescription(
                description: "Из простого дома в глубинке выходит симфония, каждый из детей – нота в мелодии жизни этой необыкновенной мамы.",
                resultText: "Один из ее сыновей оказался талантливым композитором..."),
            failureDescription: CharityDataDescription(
                description: "Сценарий из мыльной оперы: многодетная мама оказывается актрисой с выдуманными детьми. Аудитория аплодирует стоя.",
                resultText: "Бывают же на свете не честные люди, вас просто обманули, а детей то никаких и нет..."),
            profitPercentage: 6
        ),
        CharityData(
            name: "Немой певец",
            profitDescription: CharityDataDescription(
                description: "Немыслимое становится реальностью, его голос летит сквозь тишину, как фейерверк, взрывая сердца поклонников.",
                resultText: "Скорее всего это не возможно, но немой певец очень красиво поет, его талант по достоинству оценили в немеции"),
            failureDescription: CharityDataDescription(
                description: "Трагикомедия без слов: немой певец на сцене, и публика в недоумении, ожидая чуда, которое так и не произошло.",
                resultText: "А чего вы ожидали?..."),
            profitPercentage: 12
        ),
        CharityData(
            name: "Энтомолог в Австралии",
            profitDescription: CharityDataDescription(
                description: "В диких джунглях Австралии он находит своих шестиногих друзей, открывая мир насекомых как бесконечную волшебную страну.",
                resultText: "В Австралии очень много жучков - паучков, вы не прогадали"),
            failureDescription: CharityDataDescription(
                description: "Комедия ошибок: жучок, паучок, и наш энтомолог в роли неудачника, которого природа преподносит неожиданные уроки.",
                resultText: "Энтомолог оказался не слишком образованным, перепутал жучка с паучком и отравился"),
            profitPercentage: 38
        ),
        CharityData(
            name: "Экзорцист",
            profitDescription: CharityDataDescription(
                description: "С библией в одной руке и святой водой в другой, он борется с демонами, как супергерой в мире паранормального.",
                resultText: "Очень выгодная профессия, вокруг столько демонов!"),
            failureDescription: CharityDataDescription(
                description: "В поисках демонов, он находит лишь пустые комнаты и разочарованных клиентов, развеивая мифы, как мыльные пузыри.",
                resultText: "Как оказалось, демонов не существует"),
            profitPercentage: 47
        ),
        CharityData(
            name: "Любовь",
            profitDescription: CharityDataDescription(
                description:  "Любовь вместо денег – странный взнос для Гарварда, но оказывается, иногда чувства ценнее золота.",
                resultText: "Гарвард принял вашу оплату любовью, поздравляем!"),
            failureDescription: CharityDataDescription(
                description: "Магия любви оказалась не так сильна, когда дело касается оплаты за обучение, и Гарвард остаётся непреклонен.",
                resultText: "Почему то Гравард не принял вашу оплату любовью"),
            profitPercentage: 29
        ),
        CharityData(
            name: "Слепой художник",
            profitDescription: CharityDataDescription(
                description: "Он рисует мир, который видит сердцем, каждая картина – это путешествие в мир, где цвета звучат и образы танцуют.",
                resultText: "Талант можно проявлять даже с закрытыми глазами!"),
            failureDescription: CharityDataDescription(
                description: "Слепой художник и его полотна – как пустые страницы книги, которая так и не была написана.",
                resultText: "Ну как сказать, тут все было понятно заранее..."),
            profitPercentage: 34
        ),
        CharityData(
            name: "Глухой диджей",
            profitDescription: CharityDataDescription(
                description: "Он чувствует музыку лучше, чем кто-либо, его ритмы заставляют забыть обо всём на свете.",
                resultText: "Вполне сносную музыку пишет этот гений!"),
            failureDescription: CharityDataDescription(
                description:  "Когда музыка превращается в шум, глухой диджей превращает клубную вечеринку в тест на выносливость.",
                resultText: "У вас пошла кровь из ушей уже после первой композиции"),
            profitPercentage: 55
        ),
        
        CharityData(
            name: "Балерина-робот",
            profitDescription: CharityDataDescription(
                description: "Оказавшись первой балериной-андроидом, она завоевывает сцену, превращая каждый спектакль в технологическое чудо.",
                resultText: "Благодаря ей, наша инвестиция в робототехнику теперь танцует балет лучше, чем Никита!"),
            failureDescription: CharityDataDescription(
                description: "Робот-балерина перепутала балет с робототехникой и начала вместо па сваривать металлы, вызывая смятение среди зрителей.",
                resultText: "Оказывается, сварка металла на балетных спектаклях не так уж и популярна. Кто бы мог подумать?"),
            profitPercentage: 45
        ),
        CharityData(
            name: "Гипнотизёр-сомелье",
            profitDescription: CharityDataDescription(
                description: "Его вино заставляет забыть все проблемы, превращая каждую дегустацию в магическое путешествие.",
                resultText: "Вино, которое заставляет забыть о проблемах. Вот это я понимаю – волшебный напиток!"),
            failureDescription: CharityDataDescription(
                description: "Попытки гипнотизировать вино закончились полным фиаско, оставив клиентов в недоумении и без вкусных напитков.",
                resultText: "Похоже, гипнотизировать вино куда сложнее, чем клиентов. И оно, кажется, сопротивляется..."),
            profitPercentage: 37
        ),
        CharityData(
            name: "Клоун-политик",
            profitDescription: CharityDataDescription(
                description: "Смех и политика – странное сочетание, но его выступления превращаются в легендарные шоу, меняющие мир к лучшему.",
                resultText: "Кто знал, что сочетание политики и циркового шоу так увлекательно? Голосуйте за Клоуна!"
            ),
            failureDescription: CharityDataDescription(
                description: "Вместо серьёзной политики, он превращает каждое заседание в цирковое представление, вызывая вопросы у избирателей.",
                resultText: "Оказывается, пироги в лицо коллегам на политических дебатах не так уж и способствуют продуктивному диалогу."
            ),
            profitPercentage: 28
        ),
        
        CharityData(
            name: "Пират-программист",
            profitDescription: CharityDataDescription(
                description: "Он взламывает цифровые моря, создавая легендарные программы за 300к в наносек, которые становятся хитами в IT-мире.",
                resultText: "Кто бы мог подумать, что пиратский код — это не только о море. IT-сундуки полны сокровищ!"
            ),
            failureDescription: CharityDataDescription(
                description: "Попытка объединить морской разбой с кодированием приводит к хаотичному коду, вызывающему сбои в системах.",
                resultText: "Оказалось, что 'Аррр' и 'Фича' – это не лучшие пароли для корпоративных систем безопасности."
            ),
            profitPercentage: 46
        ),
        
        CharityData(
            name: "Археолог-рэпер",
            profitDescription: CharityDataDescription(
                description: "Его рифмы раскрывают древние тайны, а каждый альбом – это путешествие в прошлое.",
                resultText: "Он раскапывает рифмы так же легко, как и артефакты. Его альбомы – как исторические экспедиции!"
            ),
            failureDescription: CharityDataDescription(
                description: "Забыв о прошлом, он использует древние артефакты в качестве реквизита для своих клипов, вызывая скандалы.",
                resultText: "Использование мумий в качестве реквизита для клипов, видимо, не лучшая идея для популярности в археологическом сообществе."
            ),
            profitPercentage: 33
        ),
        
        CharityData(
            name: "Волшебник-бухгалтер",
            profitDescription: CharityDataDescription(
                description: "С помощью волшебства он превращает бухгалтерские отчеты в увлекательные истории, завоёвывая уважение клиентов.",
                resultText: "Кто знал, что 'абракадабра' может за вас писать налоговые отчеты?"
            ),
            failureDescription: CharityDataDescription(
                description: "Колдовские числа заставляют финансовые отчёты исчезать, а на их месте появляются люди в погонах",
                resultText: "Кажется, наши финансы превратились в кролика, кролик - в яйцо, а яйцо - в заложника налоговой!"
            ),
            profitPercentage: 41
        ),
        
        CharityData(
            name: "Вампир-бариста",
            profitDescription: CharityDataDescription(
                description: "Его кофе – как эликсир ночи, заряжающий энергией и пробуждающий тёмные страсти.",
                resultText:  "Его кофе настолько хорош, что клиенты готовы стоять в очереди целую ночь. Буквально!"
            ),
            failureDescription: CharityDataDescription(
                description: "Забыв о солнце, его утренние смены заканчиваются быстро как крем-брюле с хрутящей корочкой, а он поспешно убегает от первых лучей рассвета.",
                resultText: "Оказывается, утренние смены и вампиры - не лучшее сочетание. Кто бы мог подумать?"
            ),
            profitPercentage: 50
        ),
        
        CharityData(
            name: "Шахматист-иллюзионист",
            profitDescription: CharityDataDescription(
                description: "С каждым его ходом фигуры как будто оживают, создавая на доске волшебное зрелище.",
                resultText:  "Его шахматные партии так же завораживающи, как фокусы Дэвида Копперфильда. Шах и мат, исчезновение!"
            ),
            failureDescription: CharityDataDescription(
                description: "Фокусы с фигурами превращают партию в хаос, где кони исчезают, а пешки меняют цвета.",
                resultText: "Когда твои шахматные фигуры исчезают во время партии... Наверное, это не лучшая стратегия для победы."
            ),
            profitPercentage: 43
        ),
        
        CharityData(
            name: "Повар-акробат",
            profitDescription: CharityDataDescription(
                description: "Готовит блюда, совершая сальто, его кухня – это шоу с летающими сковородками и пылающими соусами.",
                resultText: "Его кулинарные шоу стоят того, чтобы увидеть их: сальто, огонь и вкуснятина!"
            ),
            failureDescription: CharityDataDescription(
                description: "Акробатические трюки с едой заканчиваются бардаком, когда ингредиенты оказываются на потолке.",
                resultText: "Кажется, летающие ингредиенты и пылающие соусы - это не то, что ожидают увидеть клиенты в своих тарелках."
            ),
            profitPercentage: 35
        ),
        
        CharityData(
            name: "Фокусник-ветеринар",
            profitDescription: CharityDataDescription(
                description: "Лечит животных, превращая обычный приём в магическое представление, от которого исчезают все болезни.",
                resultText: "Каким-то чудом он лечит животных, превращая каждый прием в волшебное шоу. Аплодисменты и лай! Чаще всего у кошек, но все же!"
            ),
            failureDescription: CharityDataDescription(
                description: "Попытки исцелить фокусами приводят к комическим ситуациям, когда кошки летают, а собаки исчезают.",
                resultText: "Похоже, кошки и собаки не очень любят фокусы с исчезновением. И почему-то клиенты тоже."
            ),
            profitPercentage: 31
        ),
        
        CharityData(
            name: "Библиотекарь-каскадер",
            profitDescription: CharityDataDescription(
                description: "Он возвращает книги на полки, совершая невероятные трюки на мотоцикле, превращая библиотеку в экстремальный парк.",
                resultText: "Наш библиотекарь-каскадер привлек огромное количество посетителей. Теперь библиотека - новая достопримечательность города!"
            ),
            failureDescription: CharityDataDescription(
                description: "Спектакулярные трюки заканчиваются разрушением полок и книжным хаосом.",
                resultText: "К сожалению, трюки на мотоцикле не сочетаются с тишиной библиотек. Мы потеряли несколько редких изданий в книжном хаосе."
            ),
            profitPercentage: 22
        ),

        CharityData(
            name: "Кондитер-дзен-буддист",
            profitDescription: CharityDataDescription(
                description: "Его торты – это произведения дзен-искусства, каждый кусочек приносит спокойствие и умиротворение.",
                resultText: "Наши дзен-торты стали хитом! Они не только вкусные, но и помогают нашим клиентам найти внутренний покой."
            ),
            failureDescription: CharityDataDescription(
                description: "Попытки создать дзен в пирожных превращаются в абсурдные десерты, вызывающие медитативное недоумение.",
                resultText: "Попытка соединить дзен и кондитерское искусство оказалась неудачной. Наши десерты вызвали больше вопросов, чем умиротворения."
            ),
            profitPercentage: 26
        ),

        CharityData(
            name: "Плотник-философ",
            profitDescription: CharityDataDescription(
                description: "Его мебель не просто удобна, она заставляет задуматься о смысле жизни, каждый стул – это мудрость.",
                resultText: "Мебель нашего плотника-философа стала культовой. Каждый стул теперь не просто предмет интерьера, а философский артефакт."
            ),
            failureDescription: CharityDataDescription(
                description: "Философские размышления в плотницкой работе приводят к созданию бесполезных, хотя и глубокомысленных предметов.",
                resultText: "Плотник-философ слишком погрузился в размышления, и его мебель оказалась скорее произведением искусства, чем функциональной."
            ),
            profitPercentage: 38
        ),
        
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
    
    struct CharityDataDescription {
        var description: String
        var resultText: String
    }

    struct CharityData {
        var name: String
        var profitDescription: CharityDataDescription
        var failureDescription: CharityDataDescription
        var profitPercentage: Int
    }
}

