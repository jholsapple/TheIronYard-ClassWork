
class TipCalculator
{
    let total: Double
    let taxPct: Double
    let subTotal: Double
    
    init(total: Double, taxPct: Double)
    {
        self.total = total
        self.taxPct = taxPct
        self.subTotal = total / (taxPct + 1)
    }
    
    func calcTipWithTipPct(tipPct: Double) -> (tipAmount:Double, total:Double)
    {
        let tipAmount =  subTotal * tipPct
        let finalTotal = total + tipAmount
        return (tipAmount, finalTotal)
    }
    
    func printPossibleTips()
    {
        println("15%: $\(calcTipWithTipPct(0.15))")
        println("18%: $\(calcTipWithTipPct(0.18))")
        println("20%: $\(calcTipWithTipPct(0.20))")
    }
    
    func returnPossibleTips() -> [Int: (tipAmount:Double, total:Double)]
    {
        let possibleTips = [0.15, 0.18, 0.20]
        var rValue = [Int(): (tipAmount:Double(), total:Double())]
        for possibleTip in possibleTips
        {
            let intPct = Int (possibleTip*100)
            rValue[intPct] = calcTipWithTipPct(possibleTip)
        }
        return rValue
    }
}

import UIKit

class TestDataSource : NSObject, UITableViewDataSource
{
    let tipCalc = TipCalculator(total: 42.75, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmount:Double, total:Double)>()
    var sortedKeys: [Int] = []
    
    override init()
    {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        
        let tipPercent = sortedKeys[indexPath.row]
        let tipAmount = possibleTips[tipPercent]!.tipAmount
        let total = possibleTips[tipPercent]!.total
        
        cell.textLabel?.text = "\(tipPercent)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmount, total)
        
        return cell
    }
}

let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height:320), style: .Plain)
tableView.dataSource = TestDataSource()
tableView .reloadData()





