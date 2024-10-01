//
//  ReceiptView.swift
//  Jonathan_Plants
//
//  Created by Jonathan Reátegui on 2024-10-01.
//

import SwiftUI

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    var receipt: Receipt?
    
    var body: some View {
        Button{
            dismiss()
        }label: {
            Text("Done")
        }
    }
}

#Preview {
    ReceiptView()
}
