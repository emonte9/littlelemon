//
//  MenuList.swift
//  littlelemon
//
//  Created by Edgar Montero on 12/23/24.
//

import Foundation
import CoreData

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
    
    func getMenuData( Context: NSManagedObjectContext) {
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) {data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let Menu = try? decoder.decode(MenuList.self, from: data){
                    
                    
                    
                    for dish in Menu.menu{
                        let Dish = Dish(context: Context)
                        Dish.title = dish.title
                        Dish.category = dish.category
                        Dish.descriptionDish = dish.descriptionDish
                        Dish.image = dish.image
                        Dish.price = dish.price
                    }
                    try? Context.save()
                    
                }
            }
        }
        dataTask.resume()
        
    }
}
