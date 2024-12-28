//
//  Menu.swift
//  littlelemon
//
//  Created by Edgar Montero on 11/18/24.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            
            Image(/*@START_MENU_TOKEN@*/"Image Name"/*@END_MENU_TOKEN@*/)
            
            Text("Little Lemon")
                .font(.custom("Markazi Text", size: 30)).bold().padding(.top).foregroundStyle(.yellow)
            
            Text("Chicago")
                .font(.custom("Markazi Text", size: 24)).foregroundStyle(.gray).bold()
                
            
            
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").font(.custom("Markazi Text", size: 16)).foregroundStyle(.gray)
            
            
            List {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        })
    }
}

#Preview {
    Menu()
}
