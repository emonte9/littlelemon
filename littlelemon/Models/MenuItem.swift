//
//  MenuItem.swift
//  littlelemon
//
//  Created by Edgar Montero on 12/23/24.
//

import Foundation


struct MenuItem: Codable, Hashable, Identifiable {
    let id = UUID()
    let title: String
    let descriptionDish: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case descriptionDish = "description"
        case price = "price"
        case image = "image"
        case category = "category"
        
    }
}
