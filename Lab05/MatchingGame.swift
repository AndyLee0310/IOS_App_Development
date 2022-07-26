//
//  MatchingGame.swift
//  test0309
//
//  Created by Andy Lee on 2022/3/16.
//

import Foundation

class MatchingGame{
//    var cards: Array<Card>
    var cards:[Card] = []
    var flipCount:Int = 0
    var score:Int = 0
    var flipUp:Bool = false
    var theme:String = "face"
    let emojiTheme = [
        "face" : ["😋", "😇", "🤣", "😯", "🙂", "🙃", "🥲", "😍"],
        "animal" : ["🐶", "🐱", "🦊", "🐻", "🐯", "🦁", "🐹", "🐻‍❄️"],
        "food" : ["🍬", "🍫", "🍿", "🍩", "🍪", "🍼", "🫖", "☕️"],
        "car" : ["🚗", "🚕", "🚙", "🚌", "🚎", "🚐", "🚒", "🚑"],
    ]
    var emoji:[String]? = []
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    {
        get{
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp && !cards[index].isMatched{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                if(!cards[index].isMatched){
                    cards[index].isFaceUp = (index == newValue)
                }
            }
        }
    }
    
    func chooseCard(at index: Int){
//        if cards[index].isFaceUp{
//            cards[index].isFaceUp = false
//        }else{
//            cards[index].isFaceUp = true
//        }
        if !cards[index].isMatched{
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isFaceUp = true
                cards[matchIndex].isFaceUp = true
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
//                    cards[index].isFaceUp = true
                    flipCount -= 1
                    score = score + 30
                } // matched
                else {
                    score = score - 10
                }
//                indexOfOneAndOnlyFaceUpCard = index
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            }  // has another previous card face up
            else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index{
//                cards[index].isFaceUp = false
//                score = score - 10
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {  // no cards face up or 2 cards are face up
//                for flipDownIndex in cards.indices{
//                    if cards[flipDownIndex].isMatched != true {
//                        cards[flipDownIndex].isFaceUp = false
//                    }
//                }  // all cards set back to face down
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
//    func resetGame(){
////        reset game
//    }
    func randomTheme(){
        let index: Int = Int(arc4random_uniform(UInt32(emojiTheme.count)))
        theme = Array(emojiTheme.keys)[index]
        emoji = emojiTheme[theme]
    }
    
    func flipAllCards(){
//        flip all cards
        flipCount = 0
        score = score - 1000
        flipUp = !flipUp
        for index in cards.indices{
            cards[index].isFaceUp = flipUp
        }
    }
    
    init(numberOfPairsOfCards: Int){
        randomTheme()
        cards.removeAll()
        flipCount = 0
        score = 0
        flipUp = false
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

}
