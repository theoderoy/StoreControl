//
//  DemoLoopSurgeryAddAdd.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

var SurgerySuccessful = false

struct DemoLoopSurgeryAdd: View {
    @StateObject var appState = AppState()
    @State var EnablePerformButton = true
    @State var showSuccess = false
    var body: some View {
        VStack(spacing: 25) {
            Image("SurgeryIndicatorIconInApp")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .clipped()
            Text("Patching DemoLoop")
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
                .frame(width: 350)
            Text("StoreControl will attempt to repair DemoLoop by restoring the neccesary resources it does not normally come with.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Button("\(appState.ButtonText)") {
                SurgeryAdd()
                EnablePerformButton = false
            } .disabled(EnablePerformButton == false) .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: 350)
        } .sheet(isPresented: $showSuccess) {
            surgerySuccess()
        }
    }
    func SurgeryAdd() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
            consoleManager.print("Found folder: \(folderName)")
            let appBundlePath = Bundle.main.bundlePath
            consoleManager.print("Application Support Source: \(appBundlePath)")
            let originalPath = "\(appBundlePath)/Application Support"
            let destinationPath = "/private/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
            consoleManager.print("Destination Path: \(destinationPath)")
            do {
                if fileManager.fileExists(atPath: destinationPath) {
                    try fileManager.removeItem(atPath: destinationPath)
                    consoleManager.print("Existing folder removed successfully or was not found!")
                }
                try fileManager.copyItem(atPath: originalPath, toPath: destinationPath)
                consoleManager.print("Folder copied successfully!")
            } catch {
                consoleManager.print("Error copying folder: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SurgerySuccessful = true
                EnablePerformButton = true
                appState.ButtonText = "Reinstall Resources"
            }
        } else {
            consoleManager.print("Could not find folder")
            return
        }
        appState.demoloopon = true
        showSuccess = true
    }
    func searchForFolderName() -> String? {
        let fileManager = FileManager.default
        let appDirectory = "/private/var/mobile/Containers/Data/Application/"
        do {
            let folderNames = try fileManager.contentsOfDirectory(atPath: appDirectory)
            for folderName in folderNames {
                let metadataFilePath = appDirectory + folderName + "/.com.apple.mobile_container_manager.metadata.plist"
                let metadataData = try Data(contentsOf: URL(fileURLWithPath: metadataFilePath))
                let metadataPlist = try PropertyListSerialization.propertyList(from: metadataData, format: nil) as? [String: Any]
                
                if let bundleId = metadataPlist?["MCMMetadataIdentifier"] as? String, bundleId == "com.apple.ist.demoloop" {
                    return folderName
                }
            }
        } catch {
            consoleManager.print("Error: \(error.localizedDescription)")
        }
        return nil
    }
}

struct DemoLoopSurgeryAdd_Previews: PreviewProvider {
    static var previews: some View {
        DemoLoopSurgeryAdd()
    }
}

struct surgerySuccess: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
                    Image(systemName: "app.badge.checkmark.fill")
                        .imageScale(.medium)
                        .font(.system(size: 150, weight: .regular, design: .default))
                    Spacer()
                        .frame(height: 41)
                        .clipped()
                    Text("Success!")
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
                    Text("DemoLoop has been successfully patched using the selected theme.\n\nA respring or reboot should allow DemoLoop to open after 1 minute of device inactivity.")
                        .font(.subheadline.weight(.regular))
                        .frame(width: 320)
                        .clipped()
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
            Button("Dismiss") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
    }
}
