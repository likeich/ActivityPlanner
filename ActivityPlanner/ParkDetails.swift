//
//  ParkDetails.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI
import MapKit

struct ParkDetails: View {
    let park: ParkStruct
    let columns = [ GridItem(.adaptive(minimum: 100), spacing: 10) ]
    
    var body: some View {
        Form {
            if park.images.count > 0 {
                Section(header: Text(park.images[0].title)) {
                    getImageFromUrl(url: park.images[0].url, defaultFilename: "Default")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            Section(header: Text("Description")) {
                Text(park.description)
            }
            
            Section(header: Text("States")) {
                Text(park.states.replacingOccurrences(of: ",", with: ", "))
            }
            
            Section(header: Text("Images")) {
                LazyVGrid(columns: columns) {
                    ForEach(park.images, id: \.self) { images in
                        getImageFromUrl(url: images.url, defaultFilename: "Default")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            
            Section(header: Text("Activities")) {
                VStack {
                    ForEach(park.activities, id: \.self) { activity in
                        Text(activity.name)
                    }
                }
            }
            
            Section(header: Text("Map View")) {
                NavigationLink(destination: MapView(mapType: MKMapType.standard, latitude: Double(park.latitude) ?? 0.0, longitude: Double(park.longitude) ?? 0.0,
                                                    delta: 100000.0, deltaUnit: "meters", annotationTitle: park.fullName,
                                                    annotationSubtitle: park.description)) {
                    Text("MapView")
                }
            }
            
            Section(header: Text("Fee Information")) {
                VStack {
                    ForEach(park.entranceFees, id: \.self) { fees in
                        VStack {
                            Text(fees.description)
                            Text("$" + fees.cost)
                            Text("")
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(park.fullName), displayMode: .inline)
    }
}

/*
 struct ParkStruct: Decodable, Hashable {
     var id: String
     var url: String
     var fullName: String
     var description: String
     var latitude: String
     var longitude: String
     var activities: [ActivityStruct]
     var states: String
 }
 */
