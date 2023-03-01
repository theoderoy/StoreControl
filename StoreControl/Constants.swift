//
//  Constants.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

class AppState: ObservableObject {
    @AppStorage("demoloopon") var demoloopon: Bool = false
    @AppStorage("button text") var ButtonText: String = ("Restore DemoLoop")
}
var selectedtheme = ("null")
