//
//  ViewController.swift
//  test0309
//
//  Created by Andy Lee on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flpCount: UILabel!
    
    lazy var game = MatchingGame(numberOfPairsOfCards: (cardButtons.count+1)/2) //加lazy，因為app要打開才會有一些func來initialize cardButtons
    
//    var Count:Int = 0 {
//        didSet{
//            flpCount.text = "Flips:\(Count)"
//        }
//    }
    
    var numberOfPairsCard: Int{
        get{
            return (cardButtons.count+1)/2
        }
    }
    
    
    var emojiChoices = ["🎃", "👻", "🤣", "😯", "🙂", "🙃", "🥲", "✈️"]
    
    var emoji = Dictionary<Int,String>()

    @IBAction func resetGame(_ sender: Any) {
        game = MatchingGame.init(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emojiChoices = ["🎃", "👻", "🤣", "😯", "🙂", "🙃", "🥲", "✈️"]
        updateViewFromModule()
    }
        
    @IBAction func flipAll(_ sender: Any) {
        game.flipAllCards()
        updateViewFromModule()
    }
    
    @IBAction func card1(_ sender: UIButton) {
        if let cardNUmber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNUmber)
            updateViewFromModule()
        }else{
            print("not in collection")
        }
//        Count += 1
    }
    
    func updateViewFromModule() {
        flpCount.text = "Flips:\(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.5799703598, green: 0.7016554475, blue: 0.991219461, alpha: 1)
            }else {
//                if card.isMatched == true{
//                    button.backgroundColor = #colorLiteral(red: 0.4809757471, green: 0.4923017025, blue: 0.47545439, alpha: 0.5 )
//                }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.4441018105, green: 0.4976987839, blue: 0.4695675969, alpha: 0.5157802152) : #colorLiteral(red: 0.7259174585, green: 0.5126449466, blue: 1, alpha: 1)
//                    button.backgroundColor = #colorLiteral(red: 0.7259174585, green: 0.5126449466, blue: 1, alpha: 1)
//                }
            }
        }
    }
    
    func getEmoji(for card:Card) -> String {
        if emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at:randomIndex) //一邊給emoji，一邊從array拿走，避免抽到一樣的emoji
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
