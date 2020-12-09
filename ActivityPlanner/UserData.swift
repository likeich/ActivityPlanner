//
//  UserData.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import Foundation

var activityList = [ActivityStruct]()
var recreationAreaList = [ParkStruct]()
var searchedRecreationAreaList = [ParkStruct]()

let api_key = "Y5CnPHBl64hl5WjVmk45vcDfO6PTnelCSJuc4LKt"
public func createDatabases() {
    activityList = decodeJsonFileIntoArrayOfStructs(fullFilename: "Activities.json", fileLocation: "Main Bundle")
    var recData: RecData
    recData = parseJsonFromURL(fullURL: "https://developer.nps.gov/api/v1/parks?limit=800&api_key=" + api_key)
    
    recreationAreaList = recData.data
}

public func searchParks(stateCode: String, activity: String) {
    var url = "https://developer.nps.gov/api/v1/parks?stateCode=" + stateCode + "&limit=50&q=" + activity + "&api_key=" + api_key
    url = url.replacingOccurrences(of: " ", with: "%20")
    var recData: RecData
    recData = parseJsonFromURL(fullURL: url)
    searchedRecreationAreaList = recData.data
}

public func getDateFormatter() -> DateFormatter {
    // Create an instance of DateFormatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    
    return dateFormatter
}



// This is general data used throughout the project. Is observable so views can update.
final class UserData: ObservableObject {
    
    public func getParkFromId(id: String) -> ParkStruct {
        let url = "https://developer.nps.gov/api/v1/parks?parkCode=" + id + "&api_key=" + api_key
        print(url)
        print("The ID: " + id)
        var recData: RecData
        recData = parseJsonFromURL(fullURL: url)
        
        if recData.data.isEmpty {
            print("Returning the first item")
            return recreationAreaList[0]
        }
        
        return recData.data[0]
    }
    
    @Published var savedInDatabase =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    
    
    /*
     -------------------------------
     MARK: - Slide Show Declarations
     -------------------------------
     */
    let numberOfImagesInSlideShow = 9
    var counter = 0
    /*
     Create a Timer using initializer () and store its object reference into slideShowTimer.
     A Timer() object invokes a method after a certain time interval has elapsed.
     */
    var slideShowTimer = Timer()
 
    /*
     ===============================================================================
     MARK: -               Publisher-Subscriber Design Pattern
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
    
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
    
     When a change occurs in userData (e.g., deleting a country from the list, reordering countries list,
     adding a new country to the list), every View subscribed to it is notified to re-render its View.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     NOTE:  Only Views can subscribe to it. You cannot subscribe to it within
            a non-View Swift file such as our CountriesData.swift file.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
   
    // Publish countriesList with initial value of countryStructList obtained in CountriesData.swift
    //@Published var gridList = cocktailGridStructList
   
    /*
     Publish searchableOrderedCountriesList with initial value of
     orderedSearchableCountriesList obtained in CountriesData.swift
     */
    //@Published var orderedReviewList = movieReviewStructList
    // Publish imageNumber to refresh the View body in Home.swift when it is changed in the slide show
    @Published var imageNumber = 0
   
    /*
     --------------------------
     MARK: - Scheduling a Timer
     --------------------------
     */
    public func startTimer() {
        // Stop timer if running
        stopTimer()
 
        /*
         Schedule a timer to invoke the fireTimer() method given below
         after 3 seconds in a loop that repeats itself until it is stopped.
         */
        slideShowTimer = Timer.scheduledTimer(timeInterval: 3,
                             target: self,
                             selector: (#selector(fireTimer)),
                             userInfo: nil,
                             repeats: true)
    }
 
    public func stopTimer() {
        counter = 0
        slideShowTimer.invalidate()
    }
   
    @objc func fireTimer() {
        counter += 1
        if counter == numberOfImagesInSlideShow {
            counter = 0
        }
        /*
         Each time imageNumber is changed here, the View body in Home.swift will be re-rendered to
         reflect the change since it subscribes to changes in imageNumber as specified above.
         */
        imageNumber = counter
    }
 
}
