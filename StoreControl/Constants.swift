//
//  Constants.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

class AppState: ObservableObject {
    @AppStorage("DO") var demoLoopOn: Bool = false
    @AppStorage("BT") var buttonText: String = ("Restore DemoLoop")
    @AppStorage("ST") var selectedTheme: String = ("Pommes")
    @AppStorage("CAI") var customAppID: Bool = false
    @AppStorage("AIS") var appIDString: String = ("")
    @AppStorage("LT") var larioTheme: Bool = false
    @AppStorage("14IK") var fourteenIKnow: Bool = false
}
