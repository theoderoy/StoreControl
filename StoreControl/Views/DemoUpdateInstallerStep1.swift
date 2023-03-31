//
//  DemoUpdateInstallerStep1.swift
//  StoreControl
//
//  Created by Tristan on 04/03/2023.
//

import SwiftUI
import UIKit

let deviceName = UIDevice.current.name

struct DemoUpdateInstallerStep1: View {
    @State private var isPresented = false
    @State var showSuccess = false
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 25) {
                Image("ProfileInstallerIconInApp")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170)
                    .clipped()
                    .shadow(color: .blue.opacity(0.38), radius: 18, x: 0, y: 12)
                Text("Provisioning \(deviceName)")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                Text("In order to install DemoLoop authentically, you will need to install the Apple Provisioning Profile.")
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Text("Installation Instructions")
                } .buttonStyle(ButtonFromInteractfulROFL())
                .sheet(isPresented: $isPresented) {
                    ProvisionMarkdown()
                }
                NavigationLink(destination: DemoUpdateInstallerStep2()) {
                    Text("Skip & Continue")
                }
            }
            .padding(.horizontal, 20) // Add padding of 20 points on either side of the screen
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the contents
        }
    }
    
    struct DemoUpdateInstallerStep1_Previews: PreviewProvider {
        static var previews: some View {
            DemoUpdateInstallerStep1()
        }
    }
}
