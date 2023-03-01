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
            ProgressBar(progress: $progress)
                            .frame(width: 300, height: 20)
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
            self.progress = 0.3
            let appBundlePath = Bundle.main.bundlePath
            print("App bundle path: \(appBundlePath)")
            self.progress = 0.5
            let originalPath = "\(appBundlePath)/Application Support"
            let destinationPath = "/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
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
