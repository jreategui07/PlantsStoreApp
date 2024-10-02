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
    let applyDiscount: Bool
    
    init(plant: Plant, customer: Customer, quantity: Int, applyDiscount: Bool = false) {
        self.plant = plant
        self.customer = customer
        self.quantity = quantity
        self.applyDiscount = applyDiscount
    }
    
    private func basePrice() -> Double {
        switch plant.size {
        case .Small:
            return 5.0
        case .Medium:
            return 7.5
        case .Large:
            return 10.0
        }
    }
    
    private func calculateDiscountedPrice() -> Double {
        return 10.0
    }
    
    func calculateTotalBeforeTax() -> Double {
        if applyDiscount {
            // If a valid coupon is applied, then the pre-tax price of any Plants (regardless of size), is $10.00
            return calculateDiscountedPrice() * Double(quantity)
        } else {
            return basePrice() * Double(quantity)
        }
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
