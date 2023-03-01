//
//  DemoLoopSurgeryAdd.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

var SurgerySuccessful = false

struct ProgressBar: View {
    @Binding var progress: Double
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: 10)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: CGFloat(self.progress) * geometry.size.width, height: 10)
                    .animation(.linear)
            }
            .cornerRadius(5)
        }
    }
}

struct DemoLoopSurgery: View {
    @AppStorage("buttonText") var ButtonText: String = "Restore DemoLoop"
    @State var EnablePerformButton = true
    @State public var progress: Double = 0.0
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
                Text("Starting Bundle ID search")
                ProgressBar(progress: $progress)
                                .frame(width: 300, height: 20)
            }
            Text("By clicking Enable DemoLoop, StoreControl will attempt to repair DemoLoop by restoring the neccesary resources it does not normally come with.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Button("\(ButtonText)") {
                searchForBundleID(in: "/private/var/mobile/Containers/Data/Application")
                EnablePerformButton = false
            } .disabled(EnablePerformButton == false) .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: 350)
        }
    }
    func SurgeryAdd() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
                print("Found folder: \(folderName)")
            self.progress = 0.3
            let appBundlePath = Bundle.main.bundlePath
            print("Application Support Source: \(appBundlePath)")
            self.progress = 0.5
            let originalPath = "\(appBundlePath)/Application Support"
            let destinationPath = "/private/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
            print("Destination Path: \(destinationPath)")
            do {
                if fileManager.fileExists(atPath: destinationPath) {
                    try fileManager.removeItem(atPath: destinationPath)
                    print("Existing folder removed successfully or was not found!")
                    self.progress = 0.8
                }
                try fileManager.copyItem(atPath: originalPath, toPath: destinationPath)
                print("Folder copied successfully!")
            } catch {
                print("Error copying folder: \(error.localizedDescription)")
                return
            }
            self.progress = 1.0
            } else {
                print("Could not find folder")
                return
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SurgerySuccessful = true
            EnablePerformButton = true
            ButtonText = "Reinstall Resources"
            self.progress = 0.0
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
                
                if let bundleId = metadataPlist?["MCMMetadataIdentifier"] as? String, bundleId == "" {
                    return folderName
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    func searchForBundleID(in directory: String) {
        do {
            let fileManager = FileManager.default
            let contents = try fileManager.contentsOfDirectory(atPath: directory)
            for content in contents {
                let fullPath = directory + "/" + content
                print("Searching in directory: \(fullPath)")
                var isDir: ObjCBool = false
                if fileManager.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if isDir.boolValue {
                        // Recursively search subdirectories
                        searchForBundleID(in: fullPath)
                    } else {
                        // Look for Info.plist files
                        if content == "Info.plist" {
                            if let infoDict = NSDictionary(contentsOfFile: fullPath) as? [String: Any],
                                let bundleID = infoDict["CFBundleIdentifier"] as? String,
                                let appName = infoDict["CFBundleName"] as? String,
                                appName == "DemoLoop" {
                                print("Found DemoLoop app with Bundle ID: \(bundleID)")
                                EnablePerformButton = true
                            }
                        }
                    }
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct DemoLoopSurgery_Previews: PreviewProvider {
    static var previews: some View {
        DemoLoopSurgery()
    }
}
