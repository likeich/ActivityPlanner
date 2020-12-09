//
//  ParkListItem.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct ParkListItem: View {
    let park: ParkStruct
    var body: some View {
        HStack {
            if park.images.count > 0 {
                getImageFromUrl(url: park.images[0].url, defaultFilename: "Default")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100)
            }
            
            VStack {
                Text(park.fullName)
            }
        }
    }
}
