//
//  SearchRecreationAreas.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct SearchRecreationAreas: View {
    
    @State private var selectedIndex = 0
    @State private var recreationAreaIndex = 0
    @State private var stateText = ""
    @State private var searched = false
    
    var body: some View {
        Form {
            Section(header: Text("Choose Activity")) {
                Picker("Selected Activity: ", selection: $selectedIndex) {
                    ForEach(0 ..< activityList.count, id: \.self) {
                        Text(activityList[$0].name)
                    }
                }
            }
            
            Section(header: Text("Enter State")) {
                TextField("Enter Abbreviation", text: $stateText)
            }
            
            if stateText.count == 2 {
                Section(header: Text("Search")) {
                    Button("Search", action: {
                        searchParks(stateCode: stateText, activity: activityList[selectedIndex].name)
                        if !searchedRecreationAreaList.isEmpty {
                            searched = true
                        } else {
                            //Show alert
                        }
                    })
                }
            }
            
            if searched {
                Section(header: Text("Found Recreation Areas")) {
                    NavigationLink("Parks", destination: RecreationAreaList(searchedList: searchedRecreationAreaList))
                }
            }
        }
        .navigationBarTitle(Text("Recreation Area Search"), displayMode: .inline)
    }
}

struct SearchRecreationAreas_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecreationAreas()
    }
}
