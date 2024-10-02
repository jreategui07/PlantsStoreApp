//
//  ContentView.swift
//  Jonathan_Plants
//
//  Created by Jonathan Reátegui on 2024-10-01.
//

import SwiftUI

struct ContentView: View {
    // Boolean var to control the presentation of the Receipt view
    @State private var presentReceiptView: Bool = false
    
    // Plant values
    @State private var plantType: PlantType = PlantType.Indoor
    @State private var plantSize: PlantSize = PlantSize.Medium
    
    // Customer values
    @State private var customerFullName: String = ""
    @State private var customerPhoneNumber: String = ""
    
    // Receipt values
    @State private var discountCode: String = ""
    @State private var quantity: Int = 1

    // Boolean var to control error
    @State private var showErrorMessage: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        // 2. Image of Plants/Nursery: Display an image representing a plant or the plant nursery.
                        Image("nursery")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())
                    
                    Section(header: Text("Plant details")) {
                        // 3. Plant Type Selector: A field to select between types of plants: Indoor, Outdoor. By default, "Indoor" is selected.
                        Text("Type")
                        Picker("Plant types", selection: $plantType) {
                            ForEach(PlantType.allCases) {
                                plantType in
                                Text(plantType.rawValue).tag(plantType)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        // 4. Plant Size Selector: A field to select the size of the plant: Small, Medium, Large. By default, "Medium" is selected.
                        Text("Size")
                        Picker("Plant Size", selection: $plantSize) {
                            ForEach(PlantSize.allCases) {
                                plantSize in
                                Text(plantSize.rawValue).tag(plantSize)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        // 5. Quantity Selector: A stepper to select the number of plants to order. Minimum quantity: 1, Maximum: 10. The default quantity is 1.
                        Stepper(value: $quantity, in: 1...10) {
                            Text("Quantity: \(quantity)")
                        }
                    }
                    
                    Section(header: Text("Customer Information")) {
                        // Ask for customer's name on screen 1
                        TextField("Customer Fullname", text: $customerFullName)
                            .keyboardType(.default)
                            .padding()
                        
                        // 6. Customer Contact Information: A mandatory field to enter the customer’s phone number. Use the appropriate keyboard type for phone numbers.
                        TextField("Phone Number", text: $customerPhoneNumber)
                            .keyboardType(.phonePad)
                            .padding()
                    }
                    
                    Section(header: Text("Discont Code")) {
                        // 7. Discount Code Field: An optional field to enter a discount code (e.g., PLANT10, GREEN15).
                        // The code is verified when the user presses the “Place Order” button.
                        // Valid codes start with the word PLANT (e.g., PLANT50).
                        // If an invalid code is entered, display an error message and clear the field without processing the order.
                        TextField("Discount Code", text: $discountCode)
                            .keyboardType(.default)
                            .padding()
                        
                        // Show error message if discount is invalid
                        if showErrorMessage {
                            Text("Invalid discount code.")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Section {
                        // 9. Navigation Bar Button - “RESET”: When tapped, this button resets the form to its default values.
                        Button {
                            resetForm()
                        } label: {
                            Text("Reset")
                                .font(.callout)
                                .foregroundColor(.red)
                        }
                        
                        // 10. Button - “PLACE ORDER”:
                        // When the user taps this button, app should navigate to the second screen with all the order details. You may send the data as separate fields or as class object.
                        // Before navigating to Screen 2, validate mandatory fields and check the validity of any entered discount codes.
                        Button {
                            placeOrder()
                        } label: {
                            Text("Place Order")
                                .font(.callout)
                        }
                        .disabled(customerPhoneNumber.isEmpty)
                    }
                }
            }
            // 1. Application Name: The name of the app should be displayed at the top.
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(5)
            .navigationTitle("Plant Order App")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $presentReceiptView) {
                let customer = Customer(fullName: customerFullName, phoneNumber: customerPhoneNumber)
                let plant = Plant(type: plantType, size: plantSize)
                let receipt = Receipt(
                    plant: plant,
                    customer: customer,
                    quantity: quantity,
                    applyDiscount: !discountCode.isEmpty
                )
                ReceiptView(receipt: receipt)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // 8. Navigation Bar Button - “GARDENER’S PICK”: When tapped, this button automatically populates the form with these values:
                    // Plant Type: Outdoor
                    // Plant Size: Large
                    // Quantity: 3
                    Button {
                        self.gardenersPickPressend()
                    } label: {
                        Text("GARDENER’S PICK")
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    private func placeOrder() {
        if (discountCode.isEmpty) {
            showErrorMessage = false
            self.presentReceiptView = true
            return
        }
        if isValidDiscountCode(discountCode) {
            showErrorMessage = false
            self.presentReceiptView = true
        } else {
            showErrorMessage = true
        }
    }

    private func resetForm() {
        plantType = PlantType.Indoor
        plantSize = PlantSize.Medium
        quantity = 1
        customerPhoneNumber = ""
        discountCode = ""
        showErrorMessage = false
    }
    
    private func gardenersPickPressend() {
        plantType = PlantType.Outdoor
        plantSize = PlantSize.Large
        quantity = 3
    }
    
    func isValidDiscountCode(_ code: String) -> Bool {
        return code.hasPrefix("PLANT")
    }
}

#Preview {
    ContentView()
}
