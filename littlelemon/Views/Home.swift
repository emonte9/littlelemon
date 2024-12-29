//
//  Home.swift
//  littlelemon
//
//  Created by Edgar Montero on 11/18/24.
//

import SwiftUI

struct Home: View {
    
    
    
    let symbols:[String] = ["list.dash", "square.and.pencil"]
    var body: some View {
        TabView(selection: .constant(1)) {
                Menu()
                    .tabItem {
                        Label("Menu", systemImage: symbols[0])
                    }
                    .tag(1)

                UserProfile()
                    .tabItem {
                        Label("Profile", systemImage: symbols[1])
                    }
                    .tag(2)
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
