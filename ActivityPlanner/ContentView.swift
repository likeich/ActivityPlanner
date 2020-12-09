//
//  ContentView.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//
import SwiftUI
import LocalAuthentication


struct ContentView: View {
    @AppStorage("status") var logged = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        if userData.userAuthenticated {
            return AnyView(Main().preferredColorScheme(.light))
        } else {
            return AnyView(Login().preferredColorScheme(.light))
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView().environmentObject(UserData())
        
    }
}
