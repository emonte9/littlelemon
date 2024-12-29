//
//  Onboarding.swift
//  littlelemon
//
//  Created by Edgar Montero on 11/17/24.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "Last name key"
let kEmail = "Email name key"
let kIsLoggedIn = "kIsLoggedIn"



struct Onboarding: View {
    @State private var firstName = "";
    @State private var lastName = "";
    @State private var email = "";
    @State private var showAlert:Bool = false;
    @State private var alertMessage = "";
    
    @State private var isLoggedIn = false;
    
    
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing:30){
                
                
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit() // Maintain aspect ratio
                    .frame(maxWidth: 200) // Set a maximum width for the logo
                
                ZStack{
                    hero().frame(maxWidth: .infinity)
                    
                }.background(Color(hex: "#495D56") ?? .black).frame(maxWidth: .infinity)
                    
                
                
                
                TextField("First name", text: $firstName).padding()
                TextField("last name", text: $lastName).padding()
                TextField("email", text: $email).padding()
                
                
                
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName);
                        UserDefaults.standard.set(lastName, forKey: kLastName);
                        UserDefaults.standard.set(email, forKey: kEmail);
                    
                        
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                
                    } else {
                        alertMessage = "Please fill in all fields."
                        showAlert = true
                        
                    }
                }.padding()
            }.padding(16).alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text(alertMessage))
            }).navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }.onAppear(){
                if UserDefaults.standard.bool(forKey: kIsLoggedIn){
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
