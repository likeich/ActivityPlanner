//
//  temp.swift
//  ActivityPlanner
//
//  Created by Abu Jalloh on 12/9/20.
//

import SwiftUI

struct temp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //        VStack {
        //
        //            //pie chart
        //            GeometryReader{g in
        //
        //                ZStack{
        //                    ForEach(0..<userData.data.count){ i in
        //                        DrawShape(center: CGPoint(x: g.frame(in: .global).width/2, y: g.frame(in: .global).height / 2), index: i)
        //                    }
        //                }
        //
        //            }.frame(height: 360)
        //            .padding(.top, 40)
        //            .clipShape(Circle())
        //            .shadow(radius: 10)
        //
        //            VStack {
        //                ForEach(userData.data){i in
        //                    HStack{
        //                        Text(i.name)
        //                            .frame(width: 100)
        //
        //                        GeometryReader{g in
        //                            HStack{
        //                                Spacer(minLength: 0)
        //                                Rectangle()
        //                                    .fill(i.color)
        //                                    .frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.percent),height: 10)
        //                                Text(String(format: "\(i.percent)", "%.0f"))
        //                                    .fontWeight(.bold)
        //                                    .padding(.leading, 10)
        //                            }//end of hstack
        //                        }//end of geometryreader
        //                    }//end of hstack
        //                    .padding(.top, 18)
        //                }
        //            }//end of vstack
        //            .padding()
        //
        //            Spacer()
        //        }//end of vstack
        //        .edgesIgnoringSafeArea(.top)
    }
}

struct temp_Previews: PreviewProvider {
    static var previews: some View {
        temp()
    }
}
