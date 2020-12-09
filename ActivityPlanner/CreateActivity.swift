//
//  CreateActivity.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct CreateActivity: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var selectedIndex = 0
    @State private var recreationAreaIndex = 0
    @State private var stateText = ""
    @State private var searched = false
    @State private var descriptionText = ""
    
    @State private var activityName = ""
    
    
    @State private var activityDate = Date()
   
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long     // e.g., August 14, 2020
        return formatter
    }
   
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 40 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -40, to: Date())!
       
        // Set maximum date to 10 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())!
        return minDate...maxDate
    }
    
    @State private var totalCost = 0.0
    @State private var activityCost = 0.0
    @State private var gasCost = 0.0
    @State private var foodCost = 0.0
    @State private var shoppingCost = 0.0

        // Define formatter before it is used
        let tripCostFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
            return numberFormatter
        }()
    
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
                        searched = true
                    })
                }
            }
            
            if searched {
                Section(header: Text("Choose Recreation Area")) {
                    VStack {
                        Picker("Selected Recreation Area: ", selection: $recreationAreaIndex) {
                            ForEach(0 ..< searchedRecreationAreaList.count, id: \.self) {
                                Text(searchedRecreationAreaList[$0].fullName)
                            }
                        }
                        
                        if !searchedRecreationAreaList.isEmpty && searchedRecreationAreaList[recreationAreaIndex].images.count > 0 {
                            Spacer()
                            
                            Text("Recreation Area Picture")
                            getImageFromUrl(url: searchedRecreationAreaList[recreationAreaIndex].images[0].url, defaultFilename: "Default")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                
                Section(header: Text("Name your activity")) {
                    TextField("Activity Name Here", text: $activityName)
                }
                
                Section(header: Text("Choose Date")) {
                    HStack {
                        Text("Choose the Date: ")
                        
                        DatePicker(selection: $activityDate,
                                    in: dateClosedRange,
                                    displayedComponents: .date){
                            Text("")
                        }
                    }
                }
                
                Section(header: Text("Enter Description")) {
                    TextEditor(text: $descriptionText)
                        .frame(height: 100)
                }
                
                Section(header: Text("Enter Projected Costs")) {
                    VStack {
                        HStack {
                            Text("Total Cost:  $")
                            TextField("Total Cost", value: $totalCost, formatter: tripCostFormatter)
                                        .keyboardType(.numbersAndPunctuation)
                        }
                        
                        HStack {
                            Text("Activity Cost:  $")
                            TextField("Total Cost", value: $activityCost, formatter: tripCostFormatter)
                                        .keyboardType(.numbersAndPunctuation)
                        }
                        
                        HStack {
                            Text("Shopping Cost:  $")
                            TextField("Total Cost", value: $shoppingCost, formatter: tripCostFormatter)
                                        .keyboardType(.numbersAndPunctuation)
                        }
                        
                        HStack {
                            Text("Food Cost:  $")
                            TextField("Total Cost", value: $foodCost, formatter: tripCostFormatter)
                                        .keyboardType(.numbersAndPunctuation)
                        }
                        
                        HStack {
                            Text("Gas Cost:  $")
                            TextField("Total Cost", value: $gasCost, formatter: tripCostFormatter)
                                        .keyboardType(.numbersAndPunctuation)
                        }
                    }
                }
                
            }
        }
        .navigationBarTitle(Text("Create Activity"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.saveActivity()
        }) {
            Text("Save")
        })
    }
    
    func saveActivity() {
        let newActivity = Activity(context: self.managedObjectContext)
        
        newActivity.title = self.activityName
        newActivity.date = self.activityDate
        newActivity.desc = self.descriptionText
        newActivity.recreationAreaID = searchedRecreationAreaList[recreationAreaIndex].parkCode
        newActivity.activityName = activityList[selectedIndex].name
        
        newActivity.totalCost = NSNumber(value: self.totalCost)
        newActivity.foodCost = NSNumber(value: self.foodCost)
        newActivity.gasCost = NSNumber(value: self.gasCost)
        newActivity.shoppingCost = NSNumber(value: self.shoppingCost)
        newActivity.activityCost = NSNumber(value: self.activityCost)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
    }
}

struct CreateActivity_Previews: PreviewProvider {
    static var previews: some View {
        CreateActivity()
    }
}
