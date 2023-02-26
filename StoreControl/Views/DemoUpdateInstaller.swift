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
                    Text("DemoLoop")
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
                    Text("Make sure DemoLoop has been installed using a third-party sideloader (SideStore, Scarlet, ETC).")
                        .font(.subheadline.weight(.regular))
                        .frame(width: 340)
                        .clipped()
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 40)
                        .clipped()
            Link(destination: URL(string: "https://demoupdate.apple.com/install/6.1.2/demoupdate.ipa")!) {
                Text("Download IPA from Apple Servers")
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(maxWidth: 340)
            Spacer()
                .frame(height: 20)
                .clipped()
            NavigationLink(destination: SpecifyAppContainer()) {
                Text("Continue")
            }
            }
    }
}

public struct ButtonFromInteractfulROFL: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 12)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14.0, style: .continuous)
                    .fill(Color.accentColor)
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}

struct DemoUpdateInstaller_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateInstaller()
    }
}
