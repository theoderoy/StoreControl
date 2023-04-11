//
//  ProvisionMarkdown.swift
//  StoreControl
//
//  Created by Tristan on 31/03/2023.
//

import SwiftUI

struct ProvisionMarkdown: View {
    @Environment(\.presentationMode) var presentationMode
    let markdownText = """
    # Installing DemoLoop authentically from Apple's Servers (since v1.1.0 Release Preview)
    To install DemoLoop directly from Apple and restore it using StoreControl, you'll need to provision it correctly to install it.

    - If you would like to skip these steps, sideloading DemoLoop with a third-party service to use it with StoreControl is partially supported as an experimental feature.

    ## Requirements

    - A Mac or Windows computer (that can run the latest of the following:)
    - Apple Configurator 2 (for macOS only) or iMazing (for macOS and Window)

    Download the Apple Partner Demo Profile here: https://github.com/Swifticul/StoreControl/raw/main/Downloads/Profiles/profile.mobileprovision

    ## Installing the Profile

    ### Using Apple Configurator 2 (for macOS only)
    1. Connect your preferred iOS device to your Mac with a USB connection.
    2. Once you see your device pop up in the initial window, drag and drop the downloaded profile onto the image of your device.
    3. Follow the remaining instructions from Apple Configurator 2 until the profile is installed.

    - You should restart your iOS device to make sure the profile is registered.

    ### Using iMazing (for macOS and Windows)
    On Windows, make sure all of the correct dependencies have been installed that iMazing prompts you to install.

    1. Connect your preferred iOS device to your computer with a USB connection.
    2. Once you see your device pop up on the right, drag and drop the downloaded profile onto the image of your device.

    - If prompted, select the Settings icon with the name "Profiles" as the target.
    - You should restart your iOS device to make sure the profile is registered.

    ## Installing the DemoLoop app
    Now that the Apple Partner Demo Profile was installed, you can install DemoLoop using StoreControl or by going to https://demoupdate.apple.com.
    """

    var body: some View {
        NavigationView {
            List {
                Section {
                    MarkdownView(markdownText: markdownText)
                        .padding()
                }
                Section {
                    Button("Go Back") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            } .navigationTitle("Documentation")
        }
    }
}

struct MarkdownView: View {
    let markdownText: String

    // Add more styles as needed
    enum TextStyle {
        case header1
        case header2
        case header3
        case bodyText
        case bullet
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(parseMarkdown(markdownText), id: \.0) { (index, element) in
                switch element.style {
                case .header1:
                    Text(element.content).font(.system(size: 34, weight: .bold))
                case .header2:
                    Text(element.content).font(.system(size: 28, weight: .bold))
                case .header3:
                    Text(element.content).font(.system(size: 22, weight: .bold))
                case .bodyText:
                    Text(element.content).font(.body)
                case .bullet:
                    HStack {
                        Text("•").font(.system(size: 20))
                        Text(element.content).font(.body)
                    }
                }
            }
        }
    }
    
    struct TextElement {
        let style: TextStyle
        let content: String
    }

    private func parseMarkdown(_ text: String) -> [(Int, TextElement)] {
        let lines = text.split(separator: "\n")
        var elements: [(Int, TextElement)] = []

        for (index, line) in lines.enumerated() {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if trimmedLine.starts(with: "# ") {
                elements.append((index, TextElement(style: .header1, content: String(trimmedLine.dropFirst(2)))))
            } else if trimmedLine.starts(with: "## ") {
                elements.append((index, TextElement(style: .header2, content: String(trimmedLine.dropFirst(3)))))
            } else if trimmedLine.starts(with: "### ") {
                elements.append((index, TextElement(style: .header3, content: String(trimmedLine.dropFirst(4)))))
            } else if trimmedLine.starts(with: "- ") {
                elements.append((index, TextElement(style: .bullet, content: String(trimmedLine.dropFirst(2)))))
            } else {
                elements.append((index, TextElement(style: .bodyText, content: String(trimmedLine))))
            }
        }

        return elements
    }
}
