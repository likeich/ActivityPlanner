//
//  Activities.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import SwiftUI

struct Activities: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("ScenicView")
                    .resizable()
                    .frame(width: 800, height: 896, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                
                VStack(spacing: 25) {
                    NavigationLink("Create Activity Plan", destination: CreateActivity())
                        .font(.title)
                        .padding(5)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(24.0)
                    
                    NavigationLink("Search Recreation Areas", destination: SearchRecreationAreas())
                        .font(.title)
                        .padding(5)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(24.0)
                    
                    Text("Upcoming Activities")
                        .font(.title)
                        .padding(5)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(24.0)
                    
                    Text("Past Activities")
                        .font(.title)
                        .padding(5)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(24.0)
                }
            }
        }
    }
}

struct Activities_Previews: PreviewProvider {
    static var previews: some View {
        Activities()
    }
}
