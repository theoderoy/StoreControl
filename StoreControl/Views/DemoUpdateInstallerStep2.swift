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
        VStack(spacing: 25) {
            Image("DemoLoopIcon")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 170)
                .clipped()
                .shadow(color: .accentColor.opacity(0.38), radius: 18, x: 0, y: 12)
            Text("Installing DemoLoop")
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
                .frame(width: 350)
            Text("You can install the DemoLoop app with iTunes directly using the Apple Partner Demo Profile.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Link(destination: URL(string: "itms-services://?action=download-manifest&url=https://demoupdate.apple.com/install/6.1.2/demoupdate.plist")!) {
                Text("Download Demo Update")
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(maxWidth: 350) .disabled(appState.customappid == true)
            NavigationLink(destination: ThemeSelectorUI()) {
                Text("Continue")
            }
        } .padding()
    }
}

struct DemoUpdateInstaller_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateInstallerStep2()
    }
}
