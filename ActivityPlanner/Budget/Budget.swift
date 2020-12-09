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
    
    @FetchRequest(fetchRequest: Activity.allActivityFetchRequest()) var allActivities: FetchedResults<Activity>
    
    
    var body: some View {
        NavigationView {
        
        BarChartView(data: ChartData(values: [("Food",getPercentages()[0]), ("Shopping",getPercentages()[1]), ("Gas",getPercentages()[2]), ("Activities",getPercentages()[3])]), title: "Budget", legend: "Trip Cost Avg: \(String(getPercentages()[4])) (\(userData.currency))",  form: ChartForm.medium, dropShadow: false, cornerImage : Image(systemName: "cedisign.circle.fill"))
        }.navigationBarTitle(("Settings"), displayMode: .inline)

    }
    
    func getWidth(width: CGFloat, value: CGFloat)->CGFloat{
        let temp = value / 100
        return temp * width
    }
    
    func getPercentages() -> [Double]{
        var gas = 0.0
        var food = 0.0
        var shop = 0.0
        var activ = 0.0
        var total = 0.0
        
        for act in allActivities {
            gas += Double(truncating: act.gasCost ?? 0)
            food += Double(truncating: act.foodCost ?? 0)
            shop += Double(truncating: act.shoppingCost ?? 0)
            activ += Double(truncating: act.activityCost ?? 0)
            total += Double(truncating: act.totalCost ?? 10000000)
        }
        
        return [food/total,shop/total, gas/total, activ/total, total/Double(allActivities.count)]
        
        
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
