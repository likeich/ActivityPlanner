//
//  ContentView.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            Activities()
                .tabItem {
                    Image(systemName: "tortoise.fill")
                    Text("Activities")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
