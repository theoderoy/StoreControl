//
//  ThemeSelectorUI.swift
//  StoreControl
//
//  Created by Tristan on 04/03/2023.
//

import SwiftUI

struct ThemeSelectorUI: View {
    @StateObject var appState = AppState()
    @State var presentSurgeryMenu = false
    @State var showSuccess = false
    @State var themeButtonPress = true
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Spacer(minLength: 15)
                    Text("Standard Themes")
                        .padding(.leading)
                        .font(.title3.weight(.semibold))
                    Text("Themes provided with Apple retail demo units")
                        .padding(.leading)
                        .font(.headline.weight(.regular))
                        .foregroundColor(.secondary)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 12) {
                            VStack {
                                Image("LogosMarker")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 140, height: .infinity)
                                    .clipped()
                                Button(action: {
                                    appState.selectedTheme = ("Pommes")
                                    consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                    presentSurgeryMenu = true
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Pommes")
                                            .font(.body.weight(.semibold))
                                            .foregroundColor(Color(.systemBackground))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(maxHeight: 40)
                                    .background(
                                        Capsule(style: .continuous)
                                            .foregroundColor(.primary)
                                    )
                                    .padding(.horizontal, 8)
                                } .sheet(isPresented: $presentSurgeryMenu) {
                                    DemoLoopSurgeryAdd()
                                }
                            } .disabled(themeButtonPress == false)
                            VStack {
                                Image("FlowersMarker")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 140, height: .infinity)
                                    .clipped()
                                Button(action: {
                                    appState.selectedTheme = ("Blooming")
                                    consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                    presentSurgeryMenu = true
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Blooming")
                                            .font(.body.weight(.semibold))
                                            .foregroundColor(Color(.systemBackground))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(maxHeight: 40)
                                    .background(
                                        Capsule(style: .continuous)
                                            .foregroundColor(.primary)
                                    )
                                    .padding(.horizontal, 8)
                                } .sheet(isPresented: $presentSurgeryMenu) {
                                    DemoLoopSurgeryAdd()
                                }
                            } .disabled(themeButtonPress == false)
                            VStack {
                                Image("TidesMarker")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 140, height: .infinity)
                                    .clipped()
                                Button(action: {
                                    appState.selectedTheme = ("Sirius")
                                    consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                    presentSurgeryMenu = true
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Sirius")
                                            .font(.body.weight(.semibold))
                                            .foregroundColor(Color(.systemBackground))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(maxHeight: 40)
                                    .background(
                                        Capsule(style: .continuous)
                                            .foregroundColor(.primary)
                                    )
                                    .padding(.horizontal, 8)
                                } .sheet(isPresented: $presentSurgeryMenu) {
                                    DemoLoopSurgeryAdd()
                                }
                            } .disabled(themeButtonPress == false)
                        }
                        .padding(.horizontal)
                    }
                    Spacer(minLength: 30)
                }
                Section {
                    VStack(alignment: .leading) {
                        Spacer(minLength: 15)
                        Text("Exclusive Themes")
                            .padding(.leading)
                            .font(.title3.weight(.semibold))
                        Text("Custom-made for StoreControl")
                            .padding(.leading)
                            .font(.headline.weight(.regular))
                            .foregroundColor(.secondary)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 12) {
                                VStack {
                                    Image("AurorusMarker")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 140, height: .infinity)
                                        .clipped()
                                    Button(action: {
                                        appState.selectedTheme = ("Aurorus")
                                        consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                        presentSurgeryMenu = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text("Aurorus")
                                                .font(.body.weight(.semibold))
                                                .foregroundColor(Color(.systemBackground))
                                            Spacer()
                                        }
                                        .padding(.horizontal, 16)
                                        .frame(maxHeight: 40)
                                        .background(
                                            Capsule(style: .continuous)
                                                .foregroundColor(.primary)
                                        )
                                        .padding(.horizontal, 8)
                                    } .sheet(isPresented: $presentSurgeryMenu) {
                                        DemoLoopSurgeryAdd()
                                    }
                                    Spacer(minLength: 15)
                                    Text("4K | 120fps")
                                        .frame(maxWidth: 145)
                                        .foregroundColor(.primary)
                                    Spacer(minLength: 5)
                                    Text("swifticul")
                                        .frame(maxWidth: 100)
                                        .foregroundColor(.secondary)
                                } .disabled(themeButtonPress == false)
                                VStack {
                                    Image("MosaicMarker")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 140, height: .infinity)
                                        .clipped()
                                    Button(action: {
                                        appState.selectedTheme = ("Mosaic")
                                        consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                        presentSurgeryMenu = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text("Mosaic")
                                                .font(.body.weight(.semibold))
                                                .foregroundColor(Color(.systemBackground))
                                            Spacer()
                                        }
                                        .padding(.horizontal, 16)
                                        .frame(maxHeight: 40)
                                        .background(
                                            Capsule(style: .continuous)
                                                .foregroundColor(.primary)
                                        )
                                        .padding(.horizontal, 8)
                                    } .sheet(isPresented: $presentSurgeryMenu) {
                                        DemoLoopSurgeryAdd()
                                    }
                                    Spacer(minLength: 15)
                                    Text("4K | 120fps")
                                        .frame(maxWidth: 145)
                                        .foregroundColor(.primary)
                                    Spacer(minLength: 5)
                                    Text("swifticul")
                                        .frame(maxWidth: 100)
                                        .foregroundColor(.secondary)
                                } .disabled(themeButtonPress == false)
                                VStack {
                                    Image("StringsMarker")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 140, height: .infinity)
                                        .clipped()
                                    Button(action: {
                                        appState.selectedTheme = ("Strings")
                                        consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                        presentSurgeryMenu = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text("Strings")
                                                .font(.body.weight(.semibold))
                                                .foregroundColor(Color(.systemBackground))
                                            Spacer()
                                        }
                                        .padding(.horizontal, 16)
                                        .frame(maxHeight: 40)
                                        .background(
                                            Capsule(style: .continuous)
                                                .foregroundColor(.primary)
                                        )
                                        .padding(.horizontal, 8)
                                    } .sheet(isPresented: $presentSurgeryMenu) {
                                        DemoLoopSurgeryAdd()
                                    }
                                    Spacer(minLength: 15)
                                    Text("4K | 120fps")
                                        .frame(maxWidth: 145)
                                        .foregroundColor(.primary)
                                    Spacer(minLength: 5)
                                    Text("swifticul")
                                        .frame(maxWidth: 100)
                                        .foregroundColor(.secondary)
                                } .disabled(themeButtonPress == false)
                                VStack {
                                    Image("BlocksMarker")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 140, height: .infinity)
                                        .clipped()
                                    Button(action: {
                                        appState.selectedTheme = ("Tidals")
                                        consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                        presentSurgeryMenu = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text("Tidals")
                                                .font(.body.weight(.semibold))
                                                .foregroundColor(Color(.systemBackground))
                                            Spacer()
                                        }
                                        .padding(.horizontal, 16)
                                        .frame(maxHeight: 40)
                                        .background(
                                            Capsule(style: .continuous)
                                                .foregroundColor(.primary)
                                        )
                                        .padding(.horizontal, 8)
                                    } .sheet(isPresented: $presentSurgeryMenu) {
                                        DemoLoopSurgeryAdd()
                                    }
                                    Spacer(minLength: 15)
                                    Text("4K | 120fps")
                                        .frame(maxWidth: 145)
                                        .foregroundColor(.primary)
                                    Spacer(minLength: 5)
                                    Text("swifticul")
                                        .frame(maxWidth: 100)
                                        .foregroundColor(.secondary)
                                } .disabled(themeButtonPress == false)
                                if appState.larioTheme {
                                    VStack {
                                        Image("SuperstarMarker")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 140, height: .infinity)
                                            .clipped()
                                        Button(action: {
                                            appState.selectedTheme = ("Lario")
                                            consoleManager.print("Selected theme is \(appState.selectedTheme)")
                                            SurgeryAdd()
                                        }) {
                                            HStack {
                                                Spacer()
                                                Text("Lario")
                                                    .font(.body.weight(.semibold))
                                                    .foregroundColor(Color(.systemBackground))
                                                Spacer()
                                            }
                                            .padding(.horizontal, 16)
                                            .frame(maxHeight: 40)
                                            .background(
                                                Capsule(style: .continuous)
                                                    .foregroundColor(.primary)
                                            )
                                            .padding(.horizontal, 8)
                                        }
                                        Capsule(style: .continuous)
                                            .frame(width: 80, height: 30)
                                            .foregroundColor(.blue)
                                            .overlay (
                                                Text("BETA")
                                                    .font(.footnote)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            )
                                            .clipShape(Capsule())
                                    } .disabled(themeButtonPress == false)
                                }
                            }
                            Spacer(minLength: 30)
                        } .padding(.horizontal)
                    }
                }
                Section {
                    Button(action: {
                        presentSurgeryMenu = true
                    }) {
                        Text("Restore Current Theme")
                    }
                    .disabled(appState.demoLoopOn == false) .sheet(isPresented: $presentSurgeryMenu) {
                        DemoLoopSurgeryAdd()
                    }
                }
            } .navigationTitle("Themes")
        } .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func SurgeryAdd() {
        themeButtonPress = false
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
            appState.buttonText = "Reinstall Resources"
            appState.demoLoopOn = true
            showSuccess = true
        }
        themeButtonPress = true
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
    
    struct ThemeSelectorUI_Previews: PreviewProvider {
        static var previews: some View {
            ThemeSelectorUI()
        }
    }
}
