//
//  header.swift
//  littlelemon
//
//  Created by Edgar Montero on 12/28/24.
//

import SwiftUI

struct header: View {
    var body: some View {
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
    }
}

#Preview {
    header()
}
