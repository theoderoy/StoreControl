//
//  DemoUpdateInstallerStep1.swift
//  StoreControl
//
//  Created by Tristan on 04/03/2023.
//

import SwiftUI
import UIKit
import WebKit

let deviceName = UIDevice.current.name

struct DemoUpdateInstallerStep1: View {
    @State private var isPresented = false
    @State var showSuccess = false
    var body: some View {
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
            Text("In order to install DemoLoop authentically, you will need to install the Apple Partner Demo Profile.\n\nIf you are planning to sideload DemoLoop using a third-party service, skip this process. You will need to specify It's App ID later on.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Button("Installation Instructions") {
                
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(maxWidth: 350)
            NavigationLink(destination: DemoUpdateInstallerStep2()) {
                    Text("Skip & Continue")
                }
            }
        }
    }

struct DemoUpdateInstallerStep1_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateInstallerStep1()
    }
}
