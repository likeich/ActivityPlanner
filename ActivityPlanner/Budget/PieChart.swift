//
//  PieChart.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/8/20.
//

import SwiftUI

struct PieChart: View {
    var body: some View {
        VStack {
            ZStack{
                HStack {
                    Button(action: {}){
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {}){
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.black)
                    }
                }
                
                Text("My Usage")
                    .fontWeight(.bold)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            padding()
                .overlay(Rectangle().stroke(Color.black.opacity(0.05), lineWidth: 2))
            
            //pie chart
            
            Path{path in
                path.move(to: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2))
                
                path.addArc(center: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 2), radius: 180, startAngle: Angle.zero, endAngle: Angle.init(degrees: 90), clockwise: false)
            }
            .fill(Color.yellow)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart()
    }
}
