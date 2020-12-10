//
//  Budget.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/8/20.
//

import SwiftUI
import SwiftUICharts

struct Budget: View {
    
    @EnvironmentObject var userData: UserData
    
    @FetchRequest(fetchRequest: Activity.allActivitiesFetchRequest()) var allActivities: FetchedResults<Activity>
    
    
    
    var body: some View {
        NavigationView {
//            HStack {
//                BarChartView(data: ChartData(values: [("Food",getPercentages()[0]), ("Shopping",getPercentages()[1]), ("Gas",getPercentages()[2]), ("Activities",getPercentages()[3])]), title: "Average Spending", legend: "Total Activity Cost Avg: \(String(getPercentages()[4])) (\(userData.currency))",  form: ChartForm.large, dropShadow: false, cornerImage : Image(systemName: "cedisign.circle.fill"))
//            }.hidden()
            
            //        BarChartView(data: ChartData(values: [("Food",getPercentages()[0]), ("Shopping",10), ("Gas",100), ("Activities",45)]), title: "Budget", legend: "Trip Cost Avg: 500 (\(userData.currency))",  form: ChartForm.medium, dropShadow: false, cornerImage : Image(systemName: "cedisign.circle.fill"))
            VStack {
                Spacer()
                    .frame(height:60)
                //pie chart
                GeometryReader{g in
                    
                    ZStack{
                        
                        ForEach(0..<userData.data.count){ i in
                            DrawShape(center: CGPoint(x: g.frame(in: .global).width/2, y: g.frame(in: .global).height / 2), index: i)
//                            getPercentages()
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
                                    Text(String(format: "%.1f%%", i.percent))
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
            .navigationBarTitle(("Costs"), displayMode: .inline)
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear { self.getPercentages() }
        
        
        
    }
    
    //use screen width for pie chart calculation
    func getWidth(width: CGFloat, value: CGFloat)->CGFloat{
        let temp = value / 100
        return temp * width
    }
    
    //get the cost breakdown
    func getPercentages(){
        
        var gas : Double = 0.0
        var food : Double = 0.0
        var shop : Double = 0.0
        var activ : Double = 0.0
        var total : Double = 0.0
        
        for act in allActivities {
            gas += Double(truncating: act.gasCost ?? 0)
            food += Double(truncating: act.foodCost ?? 0)
            shop += Double(truncating: act.shoppingCost ?? 0)
            activ += Double(truncating: act.activityCost ?? 0)
            total += Double(truncating: act.totalCost ?? 10000000)
            
            //            print(act.gasCost!)
            //            print(act.foodCost!)
            //            print(act.shoppingCost!)
        }
        
        //        return [food/Double(allActivities.count),shop/Double(allActivities.count), gas/Double(allActivities.count), activ/Double(allActivities.count), total/Double(allActivities.count)]
        
        userData.data[0].percent = CGFloat((food/total) * 100)
        userData.data[1].percent = CGFloat((shop/total) * 100)
        userData.data[2].percent = CGFloat((gas/total) * 100)
        userData.data[3].percent = CGFloat((activ/total) * 100)
        
        print("here")
        
//        return [food/total,shop/total, gas/total, activ/total, total]
      
        
    }
    
}

struct DrawShape : View {
    @EnvironmentObject var userData: UserData
    var center : CGPoint
    var index : Int
    var body: some View {
        //create a path shape for current part of pie chart using angles and radius
        Path{path in
            
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
            
        }.fill(userData.data[index].color)
    }
    //find start degree of path
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
    //find end degree of path
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
