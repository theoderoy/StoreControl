//
//  RootViewMDC.swift
//  StoreControl
//
//  Created by Tristan on 25/02/2023.
//

import SwiftUI
import Foundation
import InAppSettingsKit

struct RootViewMDC: View {
    @StateObject var appState = AppState()
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var buildNumber: String {
            guard let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return "" }
            return "     \(buildNumber)     "
        }
    func fourteenChecks() -> Bool {
        if #available(iOS 15.0, *) {
                return false
            } else {
                if appState.fourteenIKnow == true {
                    return false
                } else {
                    return true
                }
            }
        }
    @State var restoreText = ("Restore DemoLoop")
    @State var showUnpatchSuccess = false
    @State private var showiOS14Disclaimer = false
    @State var presentResetMenu = false
    let globalPadding: CGFloat = 5
    class MySettingsViewController: IASKAppSettingsViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSettingsViewController))
            navigationItem.rightBarButtonItem = doneButton
        }
        
        @objc func dismissSettingsViewController() {
            dismiss(animated: true, completion: nil)
        }
        
    }
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
                    HStack {
                        Capsule(style: .continuous)
                            .frame(width: getWidth(text: buildNumber), height: 30)
                            .clipped()
                            .foregroundColor(.blue)
                            .overlay(
                                Text("\(buildNumber)")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundColor(.white)
                            )
                    }
                } .padding(globalPadding)
                Section {
                    NavigationLink(destination: Group {
                        if appState.demoLoopOn {
                            ThemeSelectorUI()
                        } else {
                            DemoUpdateInstallerStep1()
                        }
                    }) {
                        Text("\(restoreText)")
                    } .onAppear(perform: ChangeRestoreText)
                    Button("Unpatch DemoLoop") {
                        SurgeryRemove()
                    } .disabled(appState.demoLoopOn == false)
                } footer: {
                    Text("You should only unpatch DemoLoop if you're experiencing errors and/or issues. Selecting a new theme usually just overrides the previous.")
                }
                Section {
                    Button("Open Settings Panel") {
                        let appSettingsViewController = MySettingsViewController()
                        let navigationController = UINavigationController(rootViewController: appSettingsViewController)
                        UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
                    }
                    Button("Toggle Console View") {
                        if consoleManager.isVisible == false {
                            consoleManager.isVisible = true
                        } else {
                            consoleManager.isVisible = false
                        }
                    }
                    Button("Reset All Settings") {
                        presentResetMenu = true
                    } .fullScreenCover(isPresented: $presentResetMenu) {
                        ResetConfirm()
                    } .onAppear {
                        showiOS14Disclaimer = fourteenChecks()
                    }
                } header: {
                    Text("options")
                } footer: {
                    Text("LocalConsole by duraidabdul | MDC and TCCD exploits by Ian Beer & zhuowei | Initial patching method by iBaDev")
                }
            } .onAppear(perform: PrettyPlease)
        } .navigationViewStyle(StackNavigationViewStyle()) .fullScreenCover(isPresented: $showUnpatchSuccess) {
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
            consoleManager.print("Unpatch Path: \(revokePath)")
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
                appState.demoLoopOn = false
                appState.buttonText = "Restore DemoLoop"
                showUnpatchSuccess = true
            }
        } else {
            consoleManager.print("Could not find folder")
            return
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
    func ChangeRestoreText() {
        if appState.demoLoopOn == false {
            restoreText = ("Restore DemoLoop")
        } else {
            restoreText = ("Change/Reinstall Theme")
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

func getWidth(text: String) -> CGFloat {
    let font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    return size.width
}

struct RootViewMDC_Previews: PreviewProvider {
    static var previews: some View {
        RootViewMDC()
    }
}

struct surgeryRemoveSuccess: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 25) {
                Image(systemName: "trash.slash")
                    .imageScale(.medium)
                    .font(.system(size: 150, weight: .regular, design: .default))
                    .padding(.bottom, 41)
                Text("Successfully Unpatched")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                    .padding(.bottom, 20)
                Text("StoreControl has successfully unpatched DemoLoop. You may now quit the application.")
                    .font(.subheadline.weight(.regular))
                    .frame(width: geometry.size.width - 60) // Add padding of 30 points on either side
                    .clipped()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                Button("Quit StoreControl") {
                    consoleManager.isVisible = false
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
                .buttonStyle(ButtonFromInteractfulROFL())
                .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the contents
        }
    }
}

struct ResetConfirm: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var appState = AppState()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 25) {
                Image(systemName: "questionmark.folder")
                    .imageScale(.medium)
                    .font(.system(size: 150, weight: .regular, design: .default))
                    .padding(.bottom, 41)
                Text("Resetting StoreControl")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                    .padding(.bottom, 20)
                Text("You should only perform this function if DemoLoop was uninstalled and StoreControl has not performed an unpatch, or if StoreControl is experiencing issues that unpatching cannot fix.")
                    .font(.subheadline.weight(.regular))
                    .frame(width: geometry.size.width - 60) // Add padding of 30 points on either side
                    .clipped()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                Button("I'm Sure, Continue") {
                    consoleManager.isVisible = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        appState.demoLoopOn = false
                        appState.buttonText = ("Restore DemoLoop")
                        appState.selectedTheme = ("Pommes")
                        appState.customAppID = false
                        appState.appIDString = ("")
                        appState.larioTheme = false
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            exit(0)
                        }
                    }
                }
                .buttonStyle(ButtonFromInteractfulROFL())
                .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                .padding(.bottom, 20)
                Button("No Thanks, Return") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the contents
        }
    }
}

struct DangerDangerHighVoltage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var appState = AppState()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 25) {
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.medium)
                    .font(.system(size: 150, weight: .regular, design: .default))
                    .padding(.bottom, 41)
                Text("Danger with iOS 14")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                    .padding(.bottom, 20)
                Text("StoreControl now supports iOS 14.x, but it's highly advised you use it on iOS 15.0 or later. The exploit used to modify DemoLoop can have negative consequences with the way that iOS 14 handles files and RAM. If you know exactly what you are doing, you are instructed to continue. If not, you can safely exit.")
                    .font(.subheadline.weight(.regular))
                    .frame(width: geometry.size.width - 60) // Add padding of 30 points on either side
                    .clipped()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                Button("I'm Sure, Continue") {
                    appState.fourteenIKnow = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ButtonFromInteractfulROFL())
                .frame(width: geometry.size.width - 40) // Add padding of 20 points on either side
                .padding(.bottom, 20)
                Button("No Thanks, Quit") {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the contents
        }
    }
}
