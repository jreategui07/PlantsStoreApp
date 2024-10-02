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
        switch (plant.size, plant.type) {
        case (.Small, .Indoor):
            return 15.99
        case (.Small, .Outdoor):
            return 18.99
        case (.Medium, .Indoor):
            return 24.99
        case (.Medium, .Outdoor):
            return 29.99
        case (.Large, .Indoor):
            return 34.99
        case (.Large, .Outdoor):
            return 39.99
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
