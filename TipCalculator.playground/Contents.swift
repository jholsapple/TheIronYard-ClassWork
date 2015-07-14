// Tuples
//let tipAndTotal = (4.00, 25.19)
//tipAndTotal.0
//tipAndTotal.1

//let (theTipAmt, theTotal) = tipAndTotal
//theTipAmt
//theTotal

let tipAndTotalNamed = (tipAmt: 5.00, total: 30.25)
tipAndTotalNamed.0
tipAndTotalNamed.tipAmt

let total = 21.09
let taxPercent = 0.06
let subTotal = total / (taxPercent + 1)

func calcTipWithTipPercent(tipPercent: Double) -> (tipAmount: Double, total: Double)
{
    let tipAmount = subTotal * tipPercent
    let finalTotal = total + tipAmount
    return (tipAmount, finalTotal)
}
let tipAndTotal = calcTipWithTipPercent(0.20)
tipAndTotal.tipAmount






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
    
    func calcTipWithTipPct(tipPct: Double) -> Double
    {
        return subTotal * tipPct
    }
    
    func printPossibleTips()
    {
        println("15%: $\(calcTipWithTipPct(0.15))")
        println("18%: $\(calcTipWithTipPct(0.18))")
        println("20%: $\(calcTipWithTipPct(0.20))")
    }
    
    func returnPossibleTips() -> [Int: Double]
    {
        let possibleTips = [0.15, 0.18, 0.20]
        var rValue = [Int: Double]()
        for possibleTip in possibleTips
        {
            let intPct = Int (possibleTip*100)
            rValue[intPct] = calcTipWithTipPct(possibleTip)
        }
        return rValue
    }
}

let tipCalc = TipCalculator (total: 33.25, taxPct: 0.06)
//tipCalc.printPossibleTips()
tipCalc.returnPossibleTips()