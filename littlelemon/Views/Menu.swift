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
    
    @State private var starters = false;
    @State private var mains = false;
    @State private var desserts = false;
    @State private var drinks = false;
    var body: some View {
        
        VStack(alignment: .leading) {
            header()
            ZStack{
                VStack{
                    hero()
                    
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                }.padding(10)
            }.background(Color(hex: "#495D56") ?? .black)
                   
                
            VStack (alignment: .leading){
                Text("ORDER FOR DELIVERY")
                
                ScrollView(.horizontal, showsIndicators: false){
                        HStack(){
                            Toggle("Starters", isOn: $starters).toggleStyle(ButtonToggleStyle())
                            Toggle("Mains", isOn: $mains)
                                .toggleStyle(ButtonToggleStyle())
                            Toggle("Desserts", isOn: $desserts)
                                .toggleStyle(ButtonToggleStyle())
                            Toggle("Dinks", isOn: $drinks).toggleStyle(ButtonToggleStyle())
                            
                            
                        }
                    }
                    
                }.padding()
               
            
            
            FetchedObjects(predicate:buildPredicate() , sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: DetailView(dish: dish)) {
                            Image(systemName: dish.image ?? "")
                            
                            HStack {
                                
                                VStack(alignment: .leading){
                                    // Combine title and price
                                    Text("\(dish.title ?? "Unknown Title")").bold()
                                    Text("\(dish.descriptionDish ?? "N/A")")
                                    Text("$\(dish.price ?? "N/A")")
                                }
                                
                                Spacer()
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
//        if searchText.isEmpty {
//           return NSPredicate(value: true) // Return all items if searchText is
//       } else {
//           return NSPredicate(format: "title CONTAINS[cd] %@", searchText) //
//       }
        
        
        let predicate1 = searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        
        
        let predicate2 = starters ? NSPredicate(format: "category == %@", "starters") : NSPredicate(value: true)
        
        let predicate3 = mains ? NSPredicate(format: "category == %@", "mains") : NSPredicate(value: true)
        
        
        let predicate4 = desserts ? NSPredicate(format: "category == %@", "desserts") : NSPredicate(value: true)
        
        
        let predicate5 = drinks ? NSPredicate(format: "category == %@", "Drinks") : NSPredicate(value: true)
        
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3, predicate4, predicate5])
        
        return compoundPredicate
        
        
    }
    
    
    
    struct ButtonToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            Button(action: {
                configuration.isOn.toggle()
            }) {
                HStack {
                    configuration.label // Use the label directly
                        .foregroundColor(configuration.isOn ? Color(hex: "#495D56") : .yellow)
                        .padding()
                        .background(configuration.isOn ? Color.yellow : Color(hex: "#495D56") ?? .black)
                        .cornerRadius(25)
                }
            }
            .buttonStyle(PlainButtonStyle())
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
