//
//  DemoUpdateInstallerStep2.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI
import WebKit

struct DemoUpdateInstallerStep2: View {
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
            Text("You can install the DemoLoop app with iTunes directly using the Apple Partner Demo Profile.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Button("Show DemoUpdate") {
                        isPresented = true
                    } .buttonStyle(ButtonFromInteractfulROFL()) .frame(maxWidth: 350) .sheet(isPresented: $isPresented) {
                        WebView(url: URL(string: "https://demoupdate.apple.com")!)
                    }
            NavigationLink(destination: DemoLoopSurgeryAdd()) {
                Text("Continue")
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct DemoUpdateInstaller_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateInstallerStep2()
    }
}
