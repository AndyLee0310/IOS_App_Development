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
    var flipUp:Bool = false
    
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
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cards[index].isFaceUp = true
                    flipCount -= 1
                } // matched
                indexOfOneAndOnlyFaceUpCard = index
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            }  // has another previous card face up
            else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index{
//                cards[index].isFaceUp = false
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
    
    func flipAllCards(){
//        flip all cards
        flipCount = 0
        flipUp = !flipUp
        for index in cards.indices{
            cards[index].isFaceUp = flipUp
        }
    }
    
    init(numberOfPairsOfCards: Int){
        cards.removeAll()
        flipCount = 0
        flipUp = false
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

}
