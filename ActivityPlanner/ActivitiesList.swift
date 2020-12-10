//
//  UpcomingActivities.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct ActivitiesList: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Activity.upcomingRequest(query: Date())) var upcomingActivities: FetchedResults<Activity>
    @FetchRequest(fetchRequest: Activity.passedRequest(query: Date())) var passedActivities: FetchedResults<Activity>
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(upcomingActivities, id: \.self) { activity in
                NavigationLink(destination: CDActivityDetails(activity: activity)) {
                    CDActivityListItem(activity: activity)
                }
                .background(Color.green.opacity(0.5))
            }
            
            if !passedActivities.isEmpty {
                Text("Old Activities")
                    .font(.title)
            }
            
            ForEach(passedActivities, id: \.self) { activity in
                NavigationLink(destination: CDActivityDetails(activity: activity)) {
                    CDActivityListItem(activity: activity)
                }
                .background(Color.red.opacity(0.5))
            }
            
            if passedActivities.isEmpty && upcomingActivities.isEmpty {
                Text("No Activities were Found!")
                    .font(.title)
            }
        }
        .navigationBarTitle(Text("Activities"), displayMode: .inline)
    }
}
