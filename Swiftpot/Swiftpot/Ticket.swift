//
//  Ticket.swift
//  Swiftpot
//
//  Created by John Holsapple on 7/23/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

import Foundation

class Ticket
{
    
    var winner: Bool
    var payout: String
    private var picks = Set<Int>()
    
    init()
    {
        winner = false
        payout = ""
        for i in 0..<6
        {
            createPick()
        }
    }
    
    init(picksArray: Array<Int>)
    {
        winner = false
        payout = ""
        for i in 0..<picksArray.count
        {
            picks.insert(picksArray[ i ])
        }
    }
    
    func createPick()
    {
        var pickFound = false
        do
        {
            let aPick = Int(arc4random() % 53 + 1)
            if !picks.contains(aPick)
            {
                picks.insert(aPick)
                pickFound = true
            }
        } while !pickFound
    }
    
    func description() -> String
    {
        var numbers = ""
        for pick in sorted(picks)
        {
            numbers = numbers + " \(pick)"
        }
        return numbers
    }
    
    func compartWithTicket(anotherTicket: Ticket)
    {
        let anotherTicketPicks 
    }
    
}
