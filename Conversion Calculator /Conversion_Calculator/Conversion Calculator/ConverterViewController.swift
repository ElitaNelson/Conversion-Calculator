//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Elita Nelson on 12/9/2019.
//  Copyright © 2019 Elita Nelson. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    
    struct Converter {
        let label: ConverterType

        let inputUnit: String
        let outputUnit: String

    }

    //make strings
    enum ConverterType: String {
        case fahrenheitToCelsius = "Fahrenheit to Celsius"
        case celsiusToFahrenheit = "Celsius to Fahrenheit"
        case kilometersToMiles = "Kilometers to Miles"
        case milesToKilometers = "Miles to Kilometers"
    }
    
    //action sheet
    var option: Converter = Converter(label: ConverterType.fahrenheitToCelsius, inputUnit: "°F", outputUnit: "°C")
    
    let converterArray = [Converter(label: ConverterType.fahrenheitToCelsius, inputUnit: "°F", outputUnit: "°C"),
                          Converter(label: ConverterType.celsiusToFahrenheit, inputUnit: "°C", outputUnit: "°F"),
                          Converter(label: ConverterType.milesToKilometers, inputUnit: "mi", outputUnit: "km"),
                          Converter(label: ConverterType.kilometersToMiles, inputUnit: "km", outputUnit: "mi")]
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    
    
    
    var enteredNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for converter in converterArray {
            actionSheet.addAction(UIAlertAction(title: converter.label.rawValue, style: .default, handler: { (_) in self.option = converter
                self.conversion() }
            ))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // enters numbers 0-9
    @IBAction func numberButtons(_ sender: UIButton) {
        enteredNumber += String(sender.tag)
        conversion()
    }
    
    
    // pulls up action sheet
    @IBAction func converterButton(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: {
            print("Test, Converter Button Pressed")
            
        })
        outputDisplay.text = option.outputUnit
        inputDisplay.text = option.inputUnit
    }
    
    
    // clears text fields
    @IBAction func clearButton(_ sender: Any) {
        
                outputDisplay.text = ""
                inputDisplay.text = ""
                enteredNumber = ""
    }
    
    
    // makes input number negative
    @IBAction func positiveNegativeButton(_ sender: Any) {
        var negativeNumber = false

        if enteredNumber != "" {
            
            if !negativeNumber{
                
                negativeNumber = true
                enteredNumber = "-" + enteredNumber
            }

            conversion()
        }
    }
    
    //adds deciaml
    var decimal = false

    @IBAction func decimalButton(_ sender: Any) {
                if !enteredNumber.contains("."){
        
                enteredNumber += "."
                decimal = true
                
                conversion()
                
                decimal = false
            }
        }
    
    
    // handles actual conversion / math 
    func conversion() {
        
        guard let preConvert = Float(enteredNumber)
            else {
                return
        }
        
        
        var postConvert: Float? = nil
        
        switch option.label {
            case .fahrenheitToCelsius: postConvert = (preConvert - 32) * (5/9)
            case .celsiusToFahrenheit: postConvert = (preConvert * (9/5) ) + 32
            case .milesToKilometers: postConvert = (preConvert / 0.62137)
            case .kilometersToMiles: postConvert = (preConvert * 0.62137)
        }
        
        inputDisplay.text = enteredNumber + option.inputUnit
        outputDisplay.text = String(postConvert!) + option.outputUnit
        }
        
    }
