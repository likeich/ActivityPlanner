//
//  Budget.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/8/20.
//

import SwiftUI
//import SwiftUICharts

struct Budget: View {
    @State var chartData = [("Food",63150), ("Shopping",50900), ("Gas",77550), ("Activities",79600)]
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        //        PieChartView(data: [8,23,54,32,12,37,7,23,43] , title: "Budget",legend: "Full screen", form: ChartForm.extraLarge, dropShadow: false)
        //        BarChartView(data: ChartData(values: chartData), title: "Budget", legend: "Trip (\(userData.currency))",  form: ChartForm.medium, dropShadow: false, cornerImage : Image(systemName: "cedisign.circle.fill"))
        VStack {
           
            //pie chart
            GeometryReader{g in
                
                ZStack{
                    ForEach(0..<userData.data.count){ i in
                        DrawShape(center: CGPoint(x: g.frame(in: .global).width/2, y: g.frame(in: .global).height / 2), index: i)
                    }
                }
                
            }.frame(height: 360)
            .padding(.top, 40)
            .clipShape(Circle())
            .shadow(radius: 10)
            
            VStack {
                ForEach(userData.data){i in
                    HStack{
                        Text(i.name)
                            .frame(width: 100)
                        
                        GeometryReader{g in
                            HStack{
                                Spacer(minLength: 0)
                                Rectangle()
                                    .fill(i.color)
                                    .frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.percent),height: 10)
                                Text(String(format: "\(i.percent)", "%.0f"))
                                    .fontWeight(.bold)
                                    .padding(.leading, 10)
                            }//end of hstack
                        }//end of geometryreader
                    }//end of hstack
                    .padding(.top, 18)
                }
            }//end of vstack
            .padding()
            
            Spacer()
        }//end of vstack
        .edgesIgnoringSafeArea(.top)

    }
    
    func getWidth(width: CGFloat, value: CGFloat)->CGFloat{
        let temp = value / 100
        return temp * width
    }
}

struct DrawShape : View {
    @EnvironmentObject var userData: UserData
    var center : CGPoint
    var index : Int
    var body: some View {
        Path{path in
            
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
            
        }.fill(userData.data[index].color)
    }
    
    func from()->Double{
        var temp : Double = 0
        
        if index == 0 {
            return 0
        }
        else {
            for i in 0...index-1{
                temp += Double(userData.data[i].percent / 100) * 360
            }
            return temp
        }
    }
    
    func to()->Double{
        
        var temp : Double = 0
        
        for i in 0...index{
            temp += Double(userData.data[i].percent / 100) * 360
        }
        return temp
        
        
    }
}




struct Budget_Previews: PreviewProvider {
    static var previews: some View {
        Budget()
    }
}
