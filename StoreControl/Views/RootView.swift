//
//  RootView.swift
//  StoreControl
//
//  Created by Tristan on 25/02/2023.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var body: some View {
        NavigationView {
            List {
                Section {
                    Image("IconInApp")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130)
                                    .clipped()
                            Text("StoreControl")
                                .font(.largeTitle.weight(.bold))
                    Text("Version \(appVersion ?? "AppVersion") - MDC and TCCD exploits by Ian Beer & zhuowei")
                }
                Section {
                    NavigationLink(destination: DemoUpdateInstaller()) {
                        Text("Restore DemoLoop")
                    }
                } footer: {
                    Text("You will have to have approved the sandbox escape if this is the first time you're running StoreControl.")
                } .onAppear(perform: PrettyPlease)
                Button("Change DemoLoop Icon") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }.disabled(demoloopon == false)
            }
        } .navigationViewStyle(StackNavigationViewStyle())
    }
}

func PrettyPlease() {
    grant_full_disk_access() { error in
            if (error != nil) {
                print("Failed to escape sandbox")
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
