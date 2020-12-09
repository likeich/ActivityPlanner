//
//  Main.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/3/20.
//

import SwiftUI

struct Main: View {
    var body: some View {
        TabView{
            Activities()
                .tabItem {
                    Image(systemName: "tortoise.fill")
                    Text("Activities")
                }
            
            Budget()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Costs")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main().environmentObject(UserData())
    }
}
