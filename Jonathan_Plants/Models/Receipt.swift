//
//  OrderReceipt.swift
//  Jonathan_Plants
//
//  Created by Jonathan Reátegui on 2024-10-01.
//

class Receipt {
    let plant: Plant
    let customer: Customer
    let quantity: Int
    var discountApplied: Double?
    
    init(plant: Plant, customer: Customer, quantity: Int, discountApplied: Double? = nil) {
        self.plant = plant
        self.customer = customer
        self.quantity = quantity
        self.discountApplied = discountApplied
    }
    
    func calculateTotalBeforeTax() -> Double {
        let basePrice: Double

        switch plant.size {
        case .Small:
            basePrice = 5.0
        case .Medium:
            basePrice = 7.5
        case .Large:
            basePrice = 10.0
        }

        var total = basePrice * Double(quantity)

        if let discount = discountApplied { // Applying discount if apply
            total -= (total * (discount / 100))
        }

        return total
    }
    
    func calculateTaxAmount() -> Double {
        let total = calculateTotalBeforeTax()
        return total * 0.13
    }
    
    func calculateFinalCost() -> Double {
        let total = calculateTotalBeforeTax()
        let taxAmount = calculateTaxAmount()
        return total + taxAmount
    }
}
