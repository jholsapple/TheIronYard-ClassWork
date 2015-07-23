//
//  WinningTicketViewController.swift
//  Swiftpot
//
//  Created by John Holsapple on 7/23/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import UIKit

class WinningTicketViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

    @IBOutlet weak var picker: UIPickerView!
    
    var winningPicks = [Int](count: 6, repeatedValue: 0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 53
    }
    
    //MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 20.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return "\(row+1)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        winningPicks[component] = row+1
        println("\(winningPicks)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Action Handlers
    
    @IBAction func checkTicketsButton(sender: UIButton)
    {
        let winningTicket = Ticket(picksArray: winningPicks)
        
    }
    
    @IBAction func cancelButton(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
