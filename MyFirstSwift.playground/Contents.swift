let students = 2
let tiyStaff = 5
// let totalPeople = students + tiyStaff

var totalPeople = students + tiyStaff

totalPeople = 10

let classroomsExplicit: Int = 3

let priceInferred = 1299.99
let priceExplicit: Float32 = 1299.99

let onSaleInferred = false
let onSaleExplicit: Bool = true

let nameInferred = "Macbook Pro"
let nameExplicit: String = "Macbook Pro"

if onSaleExplicit
{
    println("\(nameInferred) on sale for \(priceInferred)!")
}
else
{
    println("\(nameInferred) at regular price: \(priceInferred)")
}