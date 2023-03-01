//
//  DemoLoopSurgeryAdd.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

var SurgerySuccessful = false

struct DemoLoopSurgery: View {
    @AppStorage("buttonText") var ButtonText: String = "Restore DemoLoop"
    @State var EnablePerformButton = true
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
            VStack(spacing: 10) {
                Text("Start restoring DemoLoop")
            }
            Text("By clicking Enable DemoLoop, StoreControl will attempt to repair DemoLoop by restoring the neccesary resources it does not normally come with.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Button("\(ButtonText)") {
                SurgeryAdd()
                EnablePerformButton = false
            } .disabled(EnablePerformButton == false) .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: 350)
        }
    }
    func SurgeryAdd() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
            print("Found folder: \(folderName)")
            let appBundlePath = Bundle.main.bundlePath
            print("Application Support Source: \(appBundlePath)")
            let originalPath = "\(appBundlePath)/Application Support"
            let destinationPath = "/private/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
            print("Destination Path: \(destinationPath)")
            do {
                if fileManager.fileExists(atPath: destinationPath) {
                    try fileManager.removeItem(atPath: destinationPath)
                    print("Existing folder removed successfully or was not found!")
                }
                try fileManager.copyItem(atPath: originalPath, toPath: destinationPath)
                print("Folder copied successfully!")
            } catch {
                print("Error copying folder: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SurgerySuccessful = true
                EnablePerformButton = true
                ButtonText = "Reinstall Resources"
            }
        } else {
            print("Could not find folder")
            return
        }
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
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
}

struct DemoLoopSurgery_Previews: PreviewProvider {
    static var previews: some View {
        DemoLoopSurgery()
    }
}
