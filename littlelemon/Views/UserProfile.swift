//
//  UserProfile.swift
//  littlelemon
//
//  Created by Edgar Montero on 11/18/24.
//

import SwiftUI



struct UserProfile: View {
    @Environment(\.presentationMode) var presentation // Correctly access the presentation mode
    var body: some View {
        
        header()
        
        let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "firstName"
        let lastName = UserDefaults.standard.string(forKey: kLastName) ?? "lastName"
        let email = UserDefaults.standard.string(forKey: kEmail) ?? "email@.com"
       
        VStack{
            Text("Personal information")
            
            
            Image("Profile")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding()
            
            Text("First name \(firstName)")
            Text("Last name \(lastName)")
            Text("Email \(email)")
            
            
            Button("Logout") {
               
                UserDefaults.standard.set(false, forKey: kIsLoggedIn) // Correctly set the login status
                self.presentation.wrappedValue.dismiss()
            }
            
            Spacer()
        }.padding()
        
    }
}

#Preview {
    UserProfile()
}
