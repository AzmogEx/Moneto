//
//  Item.swift
//  Moneto
//
//  Created by Adam Marzuk on 09/02/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
