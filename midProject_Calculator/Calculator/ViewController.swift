//
//  ViewController.swift
//  Calculator
//
//  Created by Andy Lee on 2022/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorOperation: UILabel!
    @IBOutlet weak var calculaotrResult: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var divBtn: UIButton!
    @IBOutlet weak var mulBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    var dot: Bool = false
    var newCalculation: Bool = false
    var acTimes:Int = 0
    
    var workings:String = "" {
        didSet {
            if (workings.first == "-" || acTimes == 1) {
                clearButton.setTitle("AC", for: UIControl.State.normal)
            } else if ((workings.contains("+") || workings.contains("-") || workings.contains("/") || workings.contains("*") || acTimes == 2) && !workings.isEmpty) {
                clearButton.setTitle("C", for: UIControl.State.normal)
            }
            updateButton(operators: workings)
            calculatorOperation.text = workings
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        // Do any additional setup after loading the view.
    }
    
    func clearAll() {
        workings = ""
        calculatorOperation.text = ""
        calculaotrResult.text = "0"
    }
    
    func validInput() -> Bool {
        var funcCharIndexs = [Int]()
        var previous: Int = -1
        
        for index in funcCharIndexs {
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
    
    func addToWorkings(value: String) {
        workings = workings + value
        calculatorOperation.text = workings
    }
    
    func getResult() {
        if workings.last != "/" || workings.last != "+" || workings.last != "-" || workings.last != "*" {
            if (validInput()) {
                let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
                let expression = NSExpression(format: checkedWorkingsForPercent)
                let result = expression.expressionValue(with: nil, context: nil) as! Double
                let resultString = formatResult(result: result)
                calculaotrResult.text = resultString
            }
        }
    }
    
    func reCalculator() {
        if calculatorOperation.text?.last == "=" {
            clearAll()
            acTimes = 2
        }
    }
    
    @IBAction func ButtonResult(_ sender: UIButton) {
        acTimes = 1
        let temp = workings
        if dot == false {
            workings += ".0"
        }
        if (validInput()) {
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculaotrResult.text = resultString
            workings = "\(resultString)"
            if (workings == "inf") {
                workings = "0"
                calculaotrResult.text! = "0"
            }
            dot = true
            calculatorOperation.text = temp + "="
        } else {
            let alert = UIAlertController(
                title: "Invalid Input", message: "Calculator unable to do math based on input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func ac(_ sender: UIButton) {
        if workings == "" {
            workings = "0"
        }
        if clearButton.titleLabel?.text == "AC" {
            clearAll()
            acTimes = 0
        } else if clearButton.titleLabel?.text == "C" {
            acTimes = 1
            calculaotrResult.text = "0"
            if workings.first == "-" {
                workings.removeAll()
            } else if ((workings.contains("+") || workings.contains("-") || workings.contains("/") || workings.contains("*")) && !workings.isEmpty) {
                workings.removeLast()
            } else {
                workings.removeAll()
            }
            dot = false
        }
    }
    
    @IBAction func ButtonPosiOrNega(_ sender: Any) {
        calculaotrResult.text = "0"
        if workings == "" {
            workings = "0"
        }
        let inputText = calculaotrResult.text
        if let inputText = inputText {
            if inputText == "" {
                calculaotrResult.text = "-" + inputText
            } else if inputText != "0" {
                calculaotrResult.text = "0"
            } else if inputText.contains("-") {
                calculaotrResult.text = inputText.replacingOccurrences(of: "-", with: "")
            }
        }
        workings += "*-1"
        getResult()
        calculatorOperation.text = calculatorOperation.text! + "="
        dot = false
    }
    
    @IBAction func ButtonPercent(_ sender: Any) {
        let inputText = calculaotrResult.text
        calculaotrResult.text = "0"
        if workings == "" {
            workings = "0"
        }
        workings += "/100"
        let temp = workings
        if let inputText = inputText {
            var outputtext = inputText
            if inputText.contains(".") {
                var distance = outputtext.distance(from: outputtext.startIndex, to: outputtext.firstIndex(of: ".")!)
                while distance <= 3 {
                    outputtext = "0" + outputtext
                    distance += 1
                }
                let dotindex = outputtext.firstIndex(of: ".")
                outputtext.remove(at: dotindex!)
                outputtext.insert(".", at: inputText.index(dotindex!, offsetBy: -2))
            } else {
                while outputtext.count < 3 {
                    outputtext = "0" + outputtext
                }
                outputtext.insert(".", at: outputtext.index(outputtext.endIndex, offsetBy: -2))
            }
            calculaotrResult.text = formatResult(result: Double(outputtext)!)
            workings = "\(outputtext)"
        }
        calculatorOperation.text = temp + "="
        dot = false
    }
    
    @IBAction func ButtonDiv(_ sender: Any) {
        acTimes = 2
        if workings == "" {
            workings = "0"
        }
        if lastOperation(operatorText: workings) {
            workings.removeLast()
        }
        getResult()
        workings += "/"
        dot = false
    }
    
    @IBAction func ButtonMul(_ sender: Any) {
        acTimes = 2
        if workings == "" {
            workings = "0"
        }
        if lastOperation(operatorText: workings) {
            workings.removeLast()
        }
        getResult()
        workings += "*"
        dot = false
    }
    
    @IBAction func ButtonSub(_ sender: Any) {
        acTimes = 2
        if workings == "" {
            workings = "0"
        }
        if lastOperation(operatorText: workings) {
            workings.removeLast()
        }
        getResult()
        workings += "-"
        dot = false
    }
    
    @IBAction func ButtonAdd(_ sender: Any) {
        acTimes = 2
        if workings == "" {
            workings = "0"
        }
        if lastOperation(operatorText: workings) {
            workings.removeLast()
        }
        getResult()
        workings += "+"
        dot = false
     }
    
    @IBAction func ButtonDot(_ sender: UIButton) {
        let inputText = calculaotrResult.text
        if let inputText = inputText {
            if !inputText.contains(".") {
                dot = true
                workings += "."
                calculaotrResult.text! += "."
            }
        }
    }
    
    @IBAction func Button0(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "0"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "0"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "0"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "0"
                    }
                }
                addToWorkings(value: "0")
            }
        }
    }

    @IBAction func Button1(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "1"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0") {
                    calculaotrResult.text = "1"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "1"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "1"
                    }
                }
                addToWorkings(value: "1")
            }
        }
    }

    @IBAction func Button2(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "2"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "2"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "2"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "2"
                    }
                }
                addToWorkings(value: "2")
            }
        }
    }

    @IBAction func Button3(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "3"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculatorOperation.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "3"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "3"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "3"
                    }
                }
                addToWorkings(value: "3")
            }
        }
    }

    @IBAction func Button4(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "4"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "4"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "4"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "4"
                    }
                }
                addToWorkings(value: "4")
            }
        }
    }

    @IBAction func Button5(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "5"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "5"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "5"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "5"
                    }
                }
                addToWorkings(value: "5")
            }
        }
    }

    @IBAction func Button6(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "6"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "6"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "6"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "6"
                    }
                }
                addToWorkings(value: "6")
            }
        }
    }

    @IBAction func Button7(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "7"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "7"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "7"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "7"
                    }
                }
                addToWorkings(value: "7")
            }
        }
    }

    @IBAction func Button8(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "8"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "8"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "8"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "8"
                    }
                }
                addToWorkings(value: "8")
            }
        }
    }

    @IBAction func Button9(_ sender: Any) {
        reCalculator()
        if workings.last == "." {
            dot = true
        }
        if (calculaotrResult.text != nil) {
            if (newCalculation == true) {
                calculaotrResult.text = "9"
                newCalculation = false
            } else {
                if (calculaotrResult.text == "0" || calculaotrResult.text == "+" || calculaotrResult.text == "-" || calculaotrResult.text == "*" || calculaotrResult.text == "/") {
                    calculaotrResult.text = "9"
                } else {
                    if (calculatorOperation.text?.last == "+" || calculatorOperation.text?.last == "-" || calculatorOperation.text?.last == "*" || calculatorOperation.text?.last == "/") {
                        calculaotrResult.text = "9"
                    } else {
                        calculaotrResult.text = calculaotrResult.text! + "9"
                    }
                }
                addToWorkings(value: "9")
            }
        }
    }
    
    func updateButton(operators: String) {
        if (operators.last == "/") {
            divBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if (operators.last == "*") {
            mulBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if (operators.last == "-") {
            subBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if (operators.last == "+") {
            addBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else{
            divBtn.backgroundColor = #colorLiteral(red: 0.6804658771, green: 0.5437620282, blue: 0.4500194788, alpha: 1)
            mulBtn.backgroundColor = #colorLiteral(red: 0.6804658771, green: 0.5437620282, blue: 0.4500194788, alpha: 1)
            subBtn.backgroundColor = #colorLiteral(red: 0.6804658771, green: 0.5437620282, blue: 0.4500194788, alpha: 1)
            addBtn.backgroundColor = #colorLiteral(red: 0.6804658771, green: 0.5437620282, blue: 0.4500194788, alpha: 1)
        }
    }
    
    func lastOperation(operatorText: String) -> Bool {
        if (operatorText.first == ("-")) {
            return true
        } else if (operatorText.last == ("/")) {
            return true
        } else if (operatorText.last == ("*")) {
            return true
        } else if (operatorText.last == ("-")) {
            return true
        } else if (operatorText.last == ("+")) {
            return true
        } else {
            return false
        }
    }
    
}
