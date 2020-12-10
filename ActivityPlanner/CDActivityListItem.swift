//
//  CDActivityListItem.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//
import SwiftUI

struct CDActivityListItem: View {
    let activity: Activity

    var body: some View {
        HStack {
            Text(activity.title ?? "No Name")

            VStack {
                Text(activity.activityName ?? "")
                Text(activity.date?.description ?? "")
            }
        }
    }
}
