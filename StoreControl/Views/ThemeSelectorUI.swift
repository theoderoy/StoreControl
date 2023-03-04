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
    var body: some View {
        List {
            Section {
                NavigationLink(destination: DemoLoopSurgeryAdd()) {
                    Text("Reinstall Current Theme")
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Spacer(minLength: 15)
                    Text("Standard Themes")
                        .padding(.leading)
                        .font(.title3.weight(.semibold))
                    Text("Screen Savers created by Apple")
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
                                    appState.selectedtheme = ("Pommes")
                                    consoleManager.print("Selected theme is \(appState.selectedtheme)")
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
                                } .fullScreenCover(isPresented: $presentSurgeryMenu) {
                                    DemoLoopSurgeryAdd()
                                }
                            }
                            VStack {
                                Image("FlowersMarker")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 140, height: .infinity)
                                    .clipped()
                                Button(action: {
                                    appState.selectedtheme = ("Blooming")
                                    consoleManager.print("Selected theme is \(appState.selectedtheme)")
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
                                } .fullScreenCover(isPresented: $presentSurgeryMenu) {
                                    DemoLoopSurgeryAdd()
                                }
                            }
                            VStack {
                                Image("TidesMarker")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 140, height: .infinity)
                                    .clipped()
                                Button(action: {
                                    appState.selectedtheme = ("Sirius")
                                    consoleManager.print("Selected theme is \(appState.selectedtheme)")
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
                                } .fullScreenCover(isPresented: $presentSurgeryMenu) {
                                    DemoLoopSurgeryAdd()
                                }
                            }
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
                        Text("Custom-Made Screen Savers")
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
                                        appState.selectedtheme = ("Aurorus")
                                        consoleManager.print("Selected theme is \(appState.selectedtheme)")
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
                                    } .fullScreenCover(isPresented: $presentSurgeryMenu) {
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
                                }
                                
                                }
                            Spacer(minLength: 30)
                            } .padding(.horizontal)
                        }
                    } .navigationViewStyle(StackNavigationViewStyle())
        }
        }
    }
    
    struct ThemeSelectorUI_Previews: PreviewProvider {
        static var previews: some View {
            ThemeSelectorUI()
        }
    }
}
