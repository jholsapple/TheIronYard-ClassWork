//
//  ViewController.swift
//  StopWatch
//
//  Created by John Holsapple on 7/16/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let stopWatch = StopWatch()
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action Handlers
    
    @IBAction func startButtonTapped(sender: AnyObject)
    {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateElapsedTimeLabel:", userInfo: nil, repeats: true)
        stopWatch.start()
    }
    
    @IBAction func stopButtonTapped(sender: AnyObject)
    {
        stopWatch.stop()
    }
    
    // MARK: misc. functions
    
    func updateElapsedTimeLabel(timer: NSTimer)
    {
        if stopWatch.isRunning
        {
            elapsedTimeLabel.text = stopWatch.elapsedTimeAsString
        }
        else
        {
            timer.invalidate()
        }
    }

}

