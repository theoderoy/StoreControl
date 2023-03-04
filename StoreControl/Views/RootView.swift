//
//  RootView.swift
//  StoreControl
//
//  Created by Tristan on 25/02/2023.
//

import SwiftUI
import Foundation

struct RootView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    @StateObject var appState = AppState()
    @State var restoreText = ("Restore DemoLoop")
    @State var showUnrestoreSuccess = false
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
                    Text("Version v\(appVersion ?? "AppVersion") - MDC and TCCD exploits by Ian Beer & zhuowei")
                }
                Section {
                    NavigationLink(destination: DemoUpdateInstaller()) {
                        Text("\(restoreText)")
                    } .onAppear(perform: ChangeRestoreText)
                    Button("Unrestore DemoLoop") {
                        SurgeryRemove()
                    }.disabled(appState.demoloopon == false)
                } footer: {
                    Text("You will have to have approved the sandbox escape if this is the first time you're running StoreControl.\nYou should only unrestore DemoLoop if you're experiencing errors and/or issues. Selecting a new theme usually just overrides the previous.")
                } .onAppear(perform: PrettyPlease)
                Section {
                    Button("Toggle Console View") {
                        if consoleManager.isVisible == false {
                            consoleManager.isVisible = true
                        } else {
                            consoleManager.isVisible = false
                        }
                    }
                } footer: {
                    Text("LocalConsole by duraidabdul")
                }
            }
        } .navigationViewStyle(StackNavigationViewStyle()) .sheet(isPresented: $showUnrestoreSuccess) {
            surgeryRemoveSuccess()
}
    }
    func SurgeryRemove() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
            consoleManager.print("Found folder: \(folderName)")
            let appBundlePath = Bundle.main.bundlePath
            consoleManager.print("Application Support Source: \(appBundlePath)")
            let revokePath = "/private/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
            consoleManager.print("Unrestore Path: \(revokePath)")
            do {
                if fileManager.fileExists(atPath: revokePath) {
                    try fileManager.removeItem(atPath: revokePath)
                    consoleManager.print("Existing folder removed successfully or was not found!")
                } else {
                    consoleManager.print("File does not exist at path \(revokePath)")
                }
            } catch {
                consoleManager.print("Error removing file at path \(revokePath): \(error.localizedDescription)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                appState.demoloopon = false
                appState.ButtonText = "Restore DemoLoop"
                showUnrestoreSuccess = true
            }
        } else {
            consoleManager.print("Could not find folder")
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
            consoleManager.print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    func ChangeRestoreText() {
        if appState.demoloopon == false {
            restoreText = ("Restore DemoLoop")
        } else {
            restoreText = ("Change Theme")
        }
    }
}

func PrettyPlease() {
    grant_full_disk_access() { error in
            if (error != nil) {
                consoleManager.print("Failed to escape sandbox")
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


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

struct surgeryRemoveSuccess: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
                    Image(systemName: "trash.square.fill")
                        .imageScale(.medium)
                        .font(.system(size: 150, weight: .regular, design: .default))
                    Spacer()
                        .frame(height: 41)
                        .clipped()
                    Text("Unrestore Successful!")
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
                    Text("DemoLoop has been successfully unpatched.")
                        .font(.subheadline.weight(.regular))
                        .frame(width: 320)
                        .clipped()
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
            Button("Dismiss and Restart") {
                        self.presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    restartApp()
                }
                    }
                }
        }
    }
