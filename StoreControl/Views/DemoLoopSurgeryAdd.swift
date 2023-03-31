//
//  DemoLoopSurgeryAddAdd.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

var SurgerySuccessful = false

struct DemoLoopSurgeryAdd: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var appState = AppState()
    @State var EnablePerformButton = true
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 25) {
                Image("SurgeryIndicatorIconInApp")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170)
                    .clipped()
                Text("Restoring DemoLoop")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width * 0.9)
                Text("StoreControl will try to restore DemoLoop and apply the selected \(appState.selectedTheme) theme.\n\n You can override this theme with a new one without having to unpatch.")
                    .font(.subheadline.weight(.regular))
                    .frame(width: geometry.size.width * 0.85)
                    .clipped()
                    .multilineTextAlignment(.center)
                Button("\(appState.buttonText)") {
                    SurgeryAdd()
                    EnablePerformButton = false
                } .disabled(EnablePerformButton == false) .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: geometry.size.width * 0.9)
                    .padding(.bottom, 20)
                Button("No Thanks, Return") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, geometry.size.width * 0.05)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color.clear)
        }
    }
    func SurgeryAdd() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
            consoleManager.print("Found folder: \(folderName)")
            let appBundlePath = Bundle.main.bundlePath
            consoleManager.print("Application Support Source: \(appBundlePath)/Themes/\(appState.selectedTheme)")
            let originalPath = "\(appBundlePath)/Themes/\(appState.selectedTheme)/Application Support"
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
        } else {
            consoleManager.print("Could not find folder")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SurgerySuccessful = true
            EnablePerformButton = true
            appState.buttonText = "Reinstall Resources"
            appState.demoLoopOn = true
            if let url = URL(string: "demoloop://") {
                UIApplication.shared.open(url)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            }
        }
    }
    func searchForFolderName() -> String? {
        if appState.customAppID == true {
            let fileManager = FileManager.default
            let appDirectory = "/private/var/mobile/Containers/Data/Application/"
            do {
                let folderNames = try fileManager.contentsOfDirectory(atPath: appDirectory)
                for folderName in folderNames {
                    let metadataFilePath = appDirectory + folderName + "/.com.apple.mobile_container_manager.metadata.plist"
                    let metadataData = try Data(contentsOf: URL(fileURLWithPath: metadataFilePath))
                    let metadataPlist = try PropertyListSerialization.propertyList(from: metadataData, format: nil) as? [String: Any]
                    
                    if let bundleId = metadataPlist?["MCMMetadataIdentifier"] as? String, bundleId == "\(appState.appIDString)" {
                        return folderName
                    }
                }
            } catch {
                consoleManager.print("Error: \(error.localizedDescription)")
            }
            return nil
        } else {
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
}
