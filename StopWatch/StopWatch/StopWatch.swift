//
//  StopWatch.swift
//  StopWatch
//
//  Created by John Holsapple on 7/16/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import Foundation

class StopWatch
{
    private var startTime: NSDate?
    var elapsedTime: NSTimeInterval
    {
        if let startTime = self.startTime
        {
            return -startTime.timeIntervalSinceNow
        }
        else
        {
            return 0
        }
    }
    
    var elapsedTimeAsString: String
    {
        return String(format: "%02d:%02d.%d", Int (elapsedTime / 60), Int (elapsedTime % 60), Int (elapsedTime * 10 % 10))
    }
    
    var isRunning: Bool
    {
        return startTime != nil
    }
    
    func start()
    {
        startTime = NSDate()
    }
    
    func stop()
    {
        startTime = nil
    }
    
}
