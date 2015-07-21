//
//  UnitConverter.swift
//  UnitConverter
//
//  Created by John Holsapple on 7/21/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import Foundation

class UnitConverter
{
//    let degreesCelsius = Float(temperatureValues[row])
//    let degreesFahrenheit = 1.8 * degreesCelsius + 32.0
    
    func degreesFahrenheit(degreesCelsius: Int) -> Int
    {
        return Int(1.8 * Float(degreesCelsius) + 32.0)
    }
    
    
    
    
}





