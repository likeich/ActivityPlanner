//
//  CDActivityDetails.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct CDActivityDetails: View {
    let activity: Activity
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    
    

    
    var body: some View {
        Form {
            Section(header: Text("Activity Type")) {
                Text(activity.activityName ?? "Great work, kid")
            }
            
            Section(header: Text("Description")) {
                Text(activity.desc ?? "Great work, kid")
            }
            
            Section(header: Text("Date")) {
                Text(getDateFormatter().string(from: activity.date ?? Date()))
            }
            
            Section(header: Text("Recreation Area Information")) {
                NavigationLink(destination: ParkDetails(park: userData.getParkFromId(id: activity.recreationAreaID ?? recreationAreaList[0].parkCode))) {
                    ParkListItem(park: (userData.getParkFromId(id: activity.recreationAreaID ?? recreationAreaList[0].parkCode)))
                }
            }
            
            if activity.picture != nil {
                Section(header: Text("Your Photo")) {
                    getImageFromBinaryData(binaryData: activity.picture, defaultFilename: "Default")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            Section(header: Text("Costs")) {
                VStack {
                    Text("Total Cost: $" + (activity.totalCost?.stringValue ?? "0.0"))
                    Text("Food Cost: $" + (activity.foodCost?.stringValue ?? "0.0"))
                    Text("Gas Cost: $" + (activity.gasCost?.stringValue ?? "0.0"))
                    Text("Shopping Cost: $" + (activity.shoppingCost?.stringValue ?? "0.0"))
                    Text("Activity Cost: $" + (activity.activityCost?.stringValue ?? "0.0"))
                }
            }
        }
        .navigationBarTitle(Text(activity.title ?? "Your Activity"))
    }
}

