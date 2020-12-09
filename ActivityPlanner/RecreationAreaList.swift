//
//  RecreationAreaList.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct RecreationAreaList: View {
    let searchedList: [ParkStruct]
    
    var body: some View {
        List {
            ForEach(searchedList, id: \.self) { aPark in
                NavigationLink(destination: ParkDetails(park: aPark)) {
                    ParkListItem(park: aPark)
                }
            }
            
            if searchedList.isEmpty {
                Text("No Results were Found!")
                    .font(.title)
            }
        }
    }
}
