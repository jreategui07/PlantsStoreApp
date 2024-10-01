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
    
    init(plant: Plant, customer: Customer, quantity: Int) {
        self.plant = plant
        self.customer = customer
        self.quantity = quantity
    }
}
