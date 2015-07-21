//
//  ViewController.swift
//  UnitConverter
//
//  Created by John Holsapple on 7/21/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
//    private var temperatureValues = [Int]()
    private var temperatureValues = (-100...100).map{ $0 }
    private let converter = UnitConverter()

    override func viewDidLoad()
    {
        super.viewDidLoad()
//        let lowerBound = -100
//        let upperBound = 100
//        for var index = lowerBound; index <= upperBound; ++index
//        {
//            temperatureValues.append(index)
//        }
//        for index in -100...100
//        {
//            temperatureValues.append(index)
//        }
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return temperatureValues.count
    }
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        let celsiusValue = temperatureValues[row]
        return "\(celsiusValue)℃"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let degreesCelsius = temperatureValues[row]
        temperatureLabel.text = "\(Int(converter.degreesFahrenheit(degreesCelsius)))℉"
    }

}

