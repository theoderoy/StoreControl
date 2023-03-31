//
//  Root.swift
//  StoreControl
//
//  Created by Tristan on 25/02/2023.
//

import SwiftUI
import LocalConsole

let consoleManager = LCManager.shared

@main
struct StoreControlApp: App {
    var body: some Scene {
        WindowGroup {
            RootViewMDC()
        }
    }
}
