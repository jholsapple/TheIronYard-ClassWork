//
//  ViewController.swift
//  ClockTower
//
//  Created by John Holsapple on 11/17/15.
//  Copyright © 2015 John Holsapple. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var clockView: ClockView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        clockView.timezone = NSTimeZone(name: "America/New_York")
        
//        let clockView = ClockView(frame: CGRect(x: view.center.x - 70, y: view.center.y - 70, width: 140, height: 140))
//        clockView.timezone = NSTimeZone(name: "America/New_York")
//        view.addSubview(clockView)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

