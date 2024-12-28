//
//  DetailView.swift
//  littlelemon
//
//  Created by Edgar Montero on 12/26/24.
//

import SwiftUI



struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let dish : Dish
    
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Show a loading indicator
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                    
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                @unknown default:
                    EmptyView()
                }
                
                Text(dish.category ?? "").font(.custom("Markazi Text", size: 30)).bold().padding(.top)
                
                HStack{
                    Text(dish.title ?? "").font(.custom("Markazi Text", size: 20)).padding(.top)
                    
                    Spacer()
                    
                    Text("$" + (dish.price ?? "N/A")).font(.custom("Markazi Text", size: 20)).bold().padding(.top)
                }.padding(.horizontal, 30)
                
                
                Text(dish.descriptionDish ?? "").font(.custom("Markazi Text", size: 20)).padding()
                
                Spacer()
            }
        }
    }
}



#Preview {
    DetailView(dish: PersistenceController.placeHodler())
}
