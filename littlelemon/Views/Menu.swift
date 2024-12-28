//
//  Menu.swift
//  littlelemon
//
//  Created by Edgar Montero on 11/18/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isDataLoaded = false // Track if data has been loaded
    @State private var searchText = ""
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit() // Maintain aspect ratio
                    .frame(maxWidth: 200) // Set a maximum width for the logo
                Spacer() // Pushes the logo to the center
                Image("Profile") // Replace with your actual image name
                    .resizable() // Make the image resizable
                    .scaledToFit() // Maintain aspect ratio
                    .frame(width: 50, height: 50) // Set a fixed size for the profile image
            }.padding(.horizontal, 30)
            
            
            ZStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Little Lemon")
                                .font(.custom("Markazi Text", size: 30)).bold().padding(.top).foregroundStyle(.yellow).padding(.bottom, 5)
                            
                            Text("Chicago")
                                .font(.custom("Markazi Text", size: 24))
                                .foregroundStyle(.gray).bold()
                                .padding(.bottom, 5)
                            
                            Text("We are a family owned\n Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.custom("Markazi Text", size: 16)).foregroundStyle(.gray)
                        }.padding(.trailing)
                        
                        Image("Hero image")
                            .resizable().scaledToFill()
                            .frame(width: 100, height: 150)
                            .cornerRadius(15)
                        
                        
                    }.padding(20)
                    
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                }.padding(10)
            }.background(Color(hex: "#495D56") ?? .black)
                   
                
                
            
            
            FetchedObjects(predicate:buildPredicate() , sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: DetailView(dish: dish)) {
                            Image(systemName: dish.image ?? "")
                            
                            HStack {
                                // Combine title and price
                                Text("\(dish.title ?? "Unknown Title")  $\(dish.price ?? "N/A")")
                                
                                // AsyncImage for the dish image
                                AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView() // Show a loading indicator
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    case .failure:
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    }
                }.listStyle(.plain)
            }
        }
        .onAppear {
            if !isDataLoaded{
                let menuList = MenuList(menu: [])
                menuList.getMenuData(Context: viewContext)
                isDataLoaded = true
            }
        }
    }
    
    
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }


    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
           return NSPredicate(value: true) // Return all items if searchText is
       } else {
           return NSPredicate(format: "title CONTAINS[cd] %@", searchText) //
       }
    }

}



extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
