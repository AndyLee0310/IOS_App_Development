//
//  Card.swift
//  test0309
//
//  Created by Andy Lee on 2022/3/16.
//

import Foundation

struct Card{
    
    var isFaceUp = false
    var isMatched = false
    var identifier:Int      // Use ID, not emoji
    
//    init(identifier i:Int){
//        id = i
//    }
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier()->Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
