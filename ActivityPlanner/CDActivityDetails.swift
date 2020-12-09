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
                Text(activity.date?.description ?? "Great work, kid")
            }
            
            Section(header: Text("Recreation Area Information")) {
                NavigationLink(destination: ParkDetails(park: userData.getParkFromId(id: activity.recreationAreaID ?? recreationAreaList[0].parkCode))) {
                    ParkListItem(park: (userData.getParkFromId(id: activity.recreationAreaID ?? recreationAreaList[0].parkCode)))
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

