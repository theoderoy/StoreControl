//
//  DemoUpdateInstaller.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

struct DemoUpdateInstaller: View {
    var body: some View {
        VStack {
            Image("DemoLoopIcon")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 170)
                .clipped()
                .shadow(color: .accentColor.opacity(0.38), radius: 18, x: 0, y: 12)
            Spacer()
                .frame(height: 41)
                .clipped()
            Text("Installing DemoLoop")
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 20)
                .clipped()
            Text("Download the IPA directly from Apple's DemoUpdate server and install the IPA using a third-party sideloader tool (SideStore, Scarlet).\n\nMake sure it is correctly installed, then click Continue.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 25)
                .clipped()
            Link(destination: URL(string: "https://demoupdate.apple.com/install/6.1.2/demoupdate.ipa")!) {
                Text("Download from Apple Server")
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(maxWidth: 350)
            Spacer()
                .frame(height: 20)
                .clipped()
            NavigationLink(destination: DemoLoopSurgeryAdd()) {
                Text("Continue")
            }
        }
    }
}

struct DemoUpdateInstaller_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateInstaller()
    }
}
