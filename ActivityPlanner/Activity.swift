//
//  Activity.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import Foundation
import CoreData

//This holds the fetch requests and members for each trip in the core data database.
public class Activity: NSManagedObject, Identifiable {
    
    @NSManaged public var activityCost: NSNumber?
    @NSManaged public var foodCost: NSNumber?
    @NSManaged public var gasCost: NSNumber?
    @NSManaged public var shoppingCost: NSNumber?
    @NSManaged public var totalCost: NSNumber?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var recreationAreaID: String?
    @NSManaged public var activityName: String?
    
    
}

extension Activity {
    //Gets all of the trip objects in the core data base. Sorted by rating then title.
    static func allActivitiesFetchRequest()->NSFetchRequest<Activity> {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest() as! NSFetchRequest<Activity>
        /*
         List the results in alphabetical order with respect to title.
         */
        request.sortDescriptors = [
            //Primary sort key: rating
            NSSortDescriptor(key: "date", ascending: true)
        ]
        
        return request
    }
    
    //Used in the search bar in the favorites menu.
    static func favoriteSearchRequest(query: String)->NSFetchRequest<Activity> {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest() as! NSFetchRequest<Activity>
        
        request.predicate = NSPredicate(format: "title CONTAINS[c] %@ OR overview CONTAINS[c] %@ OR genres CONTAINS[c] %@ OR releaseDate CONTAINS[c] %@ OR director CONTAINS[c] %@ OR topActors CONTAINS[c] %@ OR mpaaRating CONTAINS[c] %@", query)
        
        return request
    }
    
    static func upcomingRequest(query: String)->NSFetchRequest<Activity> {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest() as! NSFetchRequest<Activity>
        
        request.predicate = NSPredicate(format: "date >= %@", query)
        
        return request
    }
}
