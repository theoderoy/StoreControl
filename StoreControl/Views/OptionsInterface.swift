//
//  OptionsInterface.swift
//  StoreControl
//
//  Created by Tristan on 05/03/2023.
//

import SwiftUI

struct OptionsInterface: View {
    @StateObject var appState = AppState()
    var body: some View {
        List {
            Section {
                VStack {
                    Toggle("Use Alternative App ID", isOn: $appState.customAppID)
                    Spacer()
                        .frame(maxHeight: 20)
                    TextField("Enter App ID", text: $appState.appIDString)
                    .textFieldStyle(.roundedBorder)
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: 20)
                } .padding()
                VStack {
                    Toggle("Enable Lario Theme (treatment:on-demand-apply)", isOn: $appState.larioTheme)
                } .padding()
            } header: {
                Text("experiments")
            } footer: {
                Text("\nAlternative App IDs should only be used if you have sideloaded DemoLoop using a third-party sideloader without the neccesary provision profile.\nEnabling this treatment will also disable the Download button in DemoUpdateInstallerStep2.swift")
            }
        } .navigationTitle("Options")
    }
}

struct OptionsInterface_Previews: PreviewProvider {
    static var previews: some View {
        OptionsInterface()
    }
}
