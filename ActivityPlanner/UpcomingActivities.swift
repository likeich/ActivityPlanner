//
//  UpcomingActivities.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct UpcomingActivities: View {
    
    @FetchRequest(fetchRequest: Activity.upcomingRequest(query: Date().description)) var activities: FetchedResults<Activity>
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities, id: \.self) { activity in
                    Text(activity.date?.description ?? "No Date!")
                }
                
                if activities.isEmpty {
                    Text("No Results were Found!")
                        .font(.title)
                }
            }
        }
    }
}

struct UpcomingActivities_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingActivities()
    }
}
