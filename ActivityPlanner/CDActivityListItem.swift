//
//  CDActivityListItem.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct CDActivityListItem: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    let activity: Activity
    
    var body: some View {
        HStack {
            getImageFromUrl(url: userData.getParkFromId(id: activity.recreationAreaID ?? "").images[0].url, defaultFilename: "Default")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100)
            
            VStack(alignment: .leading) {
                Text(activity.title ?? "No Name")
                Text(activity.activityName ?? "")
                Text(getDateFormatter().string(from: activity.date ?? Date()) )
            }
        }
    }
}
