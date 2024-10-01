//
//  ReceiptView.swift
//  Jonathan_Plants
//
//  Created by Jonathan Reátegui on 2024-10-01.
//

import SwiftUI

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    var receipt: Receipt
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Order Receipt")
                .font(.largeTitle)
                .bold()

            Form {
                Text("Customer Name: \(receipt.customer.fullName)")
                 Text("Phone Number: \(receipt.customer.phoneNumber)")
                 Text("Plant Type: \(receipt.plant.type.rawValue)")
                 Text("Plant Size: \(receipt.plant.size.rawValue)")
                 Text("Quantity Ordered: \(receipt.quantity)")
                
                if let discount = receipt.discountApplied {
                    Text("Discount Applied: \(discount)%")
                } else {
                    Text("Discount Applied: None")
                }

                let taxtAmount: Double = receipt.calculateTaxAmount()
                Text("Total Tax Amount: \(String(format: "$%.2f", taxtAmount))")
                
                let finalCost: Double = receipt.calculateFinalCost()
                Text("Final Cost of Order: \(String(format: "$%.2f", finalCost))")
            }
            .font(.body)

            Spacer()

            Button {
                dismiss()
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
   let testCustomer = Customer(fullName: "John Doe", phoneNumber: "123456789")
   let testPlant = Plant(type: .Indoor, size: .Medium)
   let testReceipt = Receipt(
    plant: testPlant,
    customer: testCustomer,
    quantity: 3,
    discountApplied: 10.0
   )
    return ReceiptView(receipt: testReceipt)
}
