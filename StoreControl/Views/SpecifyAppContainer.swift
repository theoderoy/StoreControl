//
//  SpecifyAppContainer.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

struct SpecifyAppContainer: View {
    @AppStorage("DemoLoop Container ID") private var demoloopcontainerid = ("")
    var body: some View {
        VStack(spacing: 25) {
            Image("ContainerIDIconInApp")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .clipped()
            Text("Set Container ID")
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
            Text("Specify the raw name of the DemoLoop app container folder.\n\nThis can be found by running Filza and going to /private/var/Containers/Data/Application. Start searching in the folder and paste the Bundle ID of DemoLoop.\n\nYou should see a .plist file named after the Bundle ID. Click on the blue arrow next to it, back out once and you should be at the root of the DemoLoop container. Copy the folder's name and paste it here. It should look somewhat like this:")
                .font(.subheadline.weight(.semibold))
                .frame(width: 320)
                .clipped()
                .multilineTextAlignment(.center)
            Text("00000000-0000-0000-0000-000000000000")
                .font(.subheadline.weight(.semibold))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            TextField("Folder Name", text: $demoloopcontainerid)
            .textFieldStyle(.roundedBorder) .frame(width: 340)
            NavigationLink(destination: SpecifyAppContainer()) {
                Text("Continue")
            }
        }
    }
}

struct SpecifyAppContainer_Previews: PreviewProvider {
    static var previews: some View {
        SpecifyAppContainer()
    }
}
