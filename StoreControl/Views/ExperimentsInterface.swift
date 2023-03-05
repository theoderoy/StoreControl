//
//  ExperimentsInterface.swift
//  StoreControl
//
//  Created by Tristan on 05/03/2023.
//

import SwiftUI

struct ExperimentsInterface: View {
    @StateObject var appState = AppState()
    var body: some View {
        List {
            Section {
                VStack {
                    Toggle("Use Alternative App ID", isOn: $appState.customappid)
                    TextField("Enter App ID", text: $appState.appidstring)
                    .textFieldStyle(.roundedBorder)
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: 20)
                } .padding()
            } header: {
                Text("treatments")
            } footer: {
                Text("\nAlternative App IDs should only be used if you have sideloaded DemoLoop using a third-party sideloader without the neccesary provision profile.\nEnabling this treatment will also disable the Download button in DemoUpdateInstallerStep2.swift")
            }
            Section {
                VStack {
                    Toggle("Enable Lario Theme (treatment:on-demand-apply)", isOn: $appState.lariotheme)
                } .padding()
            } header: {
                Text("flags")
            } footer: {
                Text("\nLario is an experimental unit that will have possible changes in newer versions of StoreControl that are not ready for a public release, but are considered stable enough to be tested. It uses the Aurorus theme as a template.")
            }
        } .navigationTitle("Experiments")
    }
}

struct ExperimentsInterface_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentsInterface()
    }
}
