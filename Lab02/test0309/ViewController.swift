//
//  ViewController.swift
//  test0309
//
//  Created by Andy Lee on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var flipslabel: UILabel!
    
    var fcount:Int = 0
    {
        didSet {
            flipslabel.text = "Flips: \(fcount)"
        }
    }
    
    var emojiArray = ["🎃", "👻", "🤣", "😯", "🤣", "😯", "🎃", "👻"]
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func flipEachCard(_ sender: UIButton) {
        if let cardNum = cardButtons.firstIndex(of: sender) {
            print("cardNum = \(String(describing: cardNum))")
            if sender.currentTitle == emojiArray[cardNum] {
                sender.setTitle("", for: UIControl.State.normal)
                sender.backgroundColor = #colorLiteral(red: 0.7259174585, green: 0.5126449466, blue: 1, alpha: 1)
            } else {
                sender.setTitle(emojiArray[cardNum], for: UIControl.State.normal)
                sender.backgroundColor = #colorLiteral(red: 0.5799703598, green: 0.7016554475, blue: 0.991219461, alpha: 1)
            }
            fcount += 1
        }

    }
    
//    @IBAction func touchGhost(_ sender: UIButton) {
//        if (sender.currentTitle == "👻") {
//            sender.backgroundColor = #colorLiteral(red: 0.1552907526, green: 0.2465305626, blue: 1, alpha: 1)
//            //  #colorLiteral(  => 可以叫出顏色選擇器
//            sender.setTitle("", for: UIControl.State.normal)
//        } else {
//            sender.setTitle("👻", for: UIControl.State.normal)
//            sender.backgroundColor = #colorLiteral(red: 0.09274267405, green: 0.9989094138, blue: 0.8317491412, alpha: 1)
//        }
//        fcount += 1
//    }
//
//    @IBAction func touchpumpkin(_ sender: UIButton) {
//        if (sender.currentTitle == "🎃") {
//            sender.backgroundColor = #colorLiteral(red: 0.1552907526, green: 0.2465305626, blue: 1, alpha: 1)
//            //  #colorLiteral(  => 可以叫出顏色選擇器
//            sender.setTitle("", for: UIControl.State.normal)
//        } else {
//            sender.setTitle("🎃", for: UIControl.State.normal)
//            sender.backgroundColor = #colorLiteral(red: 0.09274267405, green: 0.9989094138, blue: 0.8317491412, alpha: 1)
//        }
//        fcount += 1
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

}

