//
//  ViewController.swift
//  BMI
//
//  Created by Andy Lee on 2022/3/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightFiled: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var genderSelecter: UISegmentedControl!
    @IBOutlet weak var failMsg: UILabel!
    
    @IBAction func genderSelecter(_sender: UISegmentedControl){}
     
    @IBAction func calculator (_sender: UIButton) {
        view.endEditing(true)
        if let h: Float = Float(heightFiled.text!),
           let w: Float = Float(weightField.text!) {
            let bmi: Float = round((w / pow(h/100, 2) * 10)) / 10
            bmiLabel.text = String(bmi)
            
           switch genderSelecter.selectedSegmentIndex {
                case 0:
                    if (bmi < 18.5) {
                        status.text = "Underweight"
                    } else if (bmi >= 18.5 && bmi <= 24.9) {
                        status.text = "Healthyweight"
                    } else if (bmi >= 25 && bmi <= 29.9) {
                        status.text = "Overweight"
                    } else {
                        status.text = "Obesity"
                    }
                case 1:
                    if (bmi < 18.5) {
                        status.text = "Underweight"
                    } else if (bmi >= 18.5 && bmi <= 24.9) {
                        status.text = "Healthyweight"
                    } else {
                        status.text = "It's a secret"
                    }
                default:
                    break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

