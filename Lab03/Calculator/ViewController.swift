//
//  ViewController.swift
//  Calculator
//
//  Created by Andy Lee on 2022/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var calculatorOperation: UILabel!
    @IBOutlet var calculaotrResult: UILabel!
    var workings:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func clearAll() {
        workings = ""
        calculatorOperation.text = ""
        calculaotrResult.text = "0"
    }
    func addToWorkings(value: String) {
        workings = workings + value
        calculatorOperation.text = workings
    }
    @IBAction func ac(_ sender: Any) {
        clearAll()
    }
    @IBAction func ButtonDiv(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func ButtonMul(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func ButtonSub(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func ButtonAdd(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func ButtonResult(_ sender: Any) {
        if (validInput()) {
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculaotrResult.text = resultString
        } else {
            let alert = UIAlertController(
                title: "Invalid Input", message: "Calculator unable to do math based on input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func Button9(_ sender: Any) {
        addToWorkings(value: "9")
    }
    @IBAction func Button8(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func Button7(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func Button6(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func Button5(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func Button4(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func Button3(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func Button2(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func Button1(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func Button0(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func ButtonDot(_ sender: Any) {
        addToWorkings(value: ".")
    }
    @IBAction func ButtonPercent(_ sender: Any) {
        addToWorkings(value: "%")
    }
    func validInput() -> Bool {
        var count = 0
        var funcCharIndex = [Int]()
        
        var previous: Int = -1
        
        for index in funcCharIndex {
            if (index == 0) {
                return false
            }
            if (index == workings.count - 1) {
                return false
            }
            if (previous != -1) {
                if (index - previous == 1) {
                    return false
                }
            }
            previous = index
        }
        return true
    }
}

func specialCharacter (char: Character) -> Bool {
    if (char == "*") {
        return true
    }
    if (char == "/") {
        return true
    }
    if (char == "+") {
        return true
    }
    return false
}

func formatResult(result: Double) -> String {
    if (result.truncatingRemainder(dividingBy: 1) == 0) {
        return String(format: "%.0f", result)
    } else {
        return String(format: "%.2f", result)
    }
}


