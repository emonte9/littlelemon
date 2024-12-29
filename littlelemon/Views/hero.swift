//
//  hero.swift
//  littlelemon
//
//  Created by Edgar Montero on 12/28/24.
//

import SwiftUI

struct hero: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Little Lemon")
                    .font(.custom("Markazi Text", size: 30)).bold().padding(.top).foregroundStyle(.yellow).padding(.bottom, 5)
                
                Text("Chicago")
                    .font(.custom("Markazi Text", size: 24))
                    .foregroundStyle(.white).bold()
                    .padding(.bottom, 5)
                
                Text("We are a family owned\n Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.custom("Markazi Text", size: 16)).foregroundStyle(.white)
            }.padding(.trailing)
            
            Image("Hero image")
                .resizable().scaledToFill()
                .frame(width: 100, height: 150)
                .cornerRadius(15)
            
            
        }.padding(20)
    }
}

#Preview {
    hero()
}
