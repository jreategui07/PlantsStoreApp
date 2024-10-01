//
//  enums.swift
//  Jonathan_Plants
//
//  Created by Jonathan Reátegui on 2024-10-01.
//

enum PlantType: String, CaseIterable, Identifiable {
    case Indoor = "Indoor"
    case Outdoor = "Outdoor"
    var id: PlantType { self }
}

enum PlantSize: String, CaseIterable, Identifiable {
    case Small = "Small"
    case Medium = "Medium"
    case Large = "Large"
    var id: PlantSize { self }
}
