//
//  ChecklistData.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 08/11/23.
//

import Foundation

// MARK: - Section Data Structure
//
public struct Item {
    var name: String
    var complement: String
    
    public init(name: String, complement: String) {
        self.name = name
        self.complement = complement
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}
