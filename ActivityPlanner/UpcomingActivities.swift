//
//  UpcomingActivities.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//
import SwiftUI

struct UpcomingActivities: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Activity.allActivitiesFetchRequest()) var activities: FetchedResults<Activity>
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(activities, id: \.self) { activity in
                NavigationLink(destination: CDActivityDetails(activity: activity)) {
                    CDActivityListItem(activity: activity)
                }
            }
            
            if activities.isEmpty {
                Text("No Results were Found!")
                    .font(.title)
            }
        }
        .navigationBarTitle(Text("Activities"), displayMode: .inline)
    }
}

struct UpcomingActivities_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingActivities()
    }
}
