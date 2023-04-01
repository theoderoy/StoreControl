//
//  DemoUpdateInstallerStep2.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

struct DemoUpdateInstallerStep2: View {
    @StateObject var appState = AppState()
    @State private var isPresented = false
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 25) {
                Image("DemoLoopIcon")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170)
                    .clipped()
                    .shadow(color: .orange.opacity(0.38), radius: 18, x: 0, y: 12)
                Text("Installing DemoLoop")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                Text("You can install the DemoLoop app with iTunes directly using the Apple Partner Demo Profile.")
                    .font(.subheadline.weight(.regular))
                    .frame(width: geometry.size.width - 60) // Add padding of 30 points on either side
                    .clipped()
                    .multilineTextAlignment(.center)
                Link(destination: URL(string: "itms-services://?action=download-manifest&url=https://demoupdate.apple.com/install/6.1.2/demoupdate.plist")!) {
                    Text("Download Demo Update")
                } .buttonStyle(ButtonFromInteractfulROFL())
                    .frame(maxWidth: .infinity) // Set the maximum width of the button to infinity
                .padding(.horizontal, 20) // Add padding of 20 points on either side of the button
                .disabled(appState.customAppID == true)
                NavigationLink(destination: ThemeSelectorUI()) {
                    Text("Continue")
                } .padding(.horizontal, 20) // Add padding of 20 points on either side of the screen
            } .padding() // Add padding of 20 points on all sides of the VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the contents
        }
    }
}

struct DemoUpdateInstaller_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateInstallerStep2()
    }
}
