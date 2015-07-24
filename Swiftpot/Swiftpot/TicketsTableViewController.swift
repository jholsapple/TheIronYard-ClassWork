//
//  TicketsTableViewController.swift
//  Swiftpot
//
//  Created by John Holsapple on 7/23/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import UIKit

protocol WinningTicketViewControllerDelegate
{
    func winningTicketWasAdded(ticket: Ticket)
}

class TicketsTableViewController: UITableViewController, WinningTicketViewControllerDelegate
{

    var tickets = [Ticket]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return tickets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TicketCell", forIndexPath: indexPath) as! TicketCell
        
        let aTicket = tickets[indexPath.row]
        cell.numbersLabel.text = aTicket.description()
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowWinningTicketSegue"
        {
            let ticketsVC = segue.destinationViewController as! WinningTicketViewController
            ticketsVC.delegate = self
        }
    }
    
    //MARK: - Winning Ticket View Controller Delegate
    
    func winningTicketWasAdded(ticket: Ticket)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        checkForWinnersUsingTicket(ticket)
    }
    
    func checkForWinnersUsingTicket(winningTicket: Ticket)
    {
        
    }
    
    //MARK: - Action Handlers

    @IBAction func createTicket(sender: UIBarButtonItem)
    {
        let aTicket = Ticket()
        tickets.append(aTicket)
        
        tableView.reloadData()	
    }
    

}
