//
//  PieChart.swift
//  MyWallet
//
//  Created by Arafat Hossain on 25/1/23.
//

import SwiftUI

public struct PieChart: View {
    public var values: [Double] = [Double]()
    public var names: [String] = [String]()
    public var colors: [Color] = [Color]()
    
    public let title: String
    
    public let formatter: (Double) -> String
    public var backgroundColor: Color
    
    public var innerRadius: CGFloat
    public var pieWidth: CGFloat
    
    @State private var activeIndex: Int = -1
    @State private var offset: CGFloat = 100.0
    
    var slices: [SliceData] {
        let sum = values.reduce(0, +)
        var startDegree: Double = 0
        var slices: [SliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            
            slices.append(SliceData(startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: startDegree + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            
            startDegree += degrees
        }
        
        return slices
    }
    
    public init(title: String, pieItems: [PieItem], formatter: @escaping (Double) -> String, backgroundColor: Color = .black, pieWidth: CGFloat = 0.90, innerRadius: CGFloat = 0.60) {
        
        self.title = title
        
        for item in pieItems {
            self.names.append(item.name)
            self.values.append(item.value)
            self.colors.append(item.color)
        }
        
        self.formatter = formatter
        self.backgroundColor = backgroundColor
        self.pieWidth = pieWidth
        self.innerRadius = innerRadius
    }
    
    public var body: some View {
        VStack {
            Text(self.title)
                .font(.largeTitle)
            GeometryReader { geometry in
                VStack {
                    ZStack{
                        ForEach(0..<self.values.count, id:\.self) { i in
                            PieSlice(sliceData: self.slices[i])
                                .scaleEffect(self.activeIndex == i ? 1.05 : 1)
                                .animation(.easeInOut(duration: 2.0), value: offset)
                        }
                        .padding(15)
                        .frame(width: pieWidth * geometry.size.width, height: pieWidth * geometry.size.width)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let radius = 0.5 * pieWidth * geometry.size.width
                                    let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                    let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                    if (dist > radius || dist < radius * innerRadius) {
                                        self.activeIndex = -1
                                        return
                                    }
                                    var radians = Double(atan2(diff.x, diff.y))
                                    if (radians < 0) {
                                        radians = 2 * Double.pi + radians
                                    }
                                    
                                    for (i, slice) in slices.enumerated() {
                                        if (radians < slice.endAngle.radians) {
                                            if self.activeIndex == i {
                                                self.activeIndex = -1
                                            }
                                            else {
                                                self.activeIndex = i
                                            }
                                            
                                            break
                                        }
                                    }
                                }
                        )
                        
                        Circle()
                            .fill(self.backgroundColor)
                            .frame(width: pieWidth * geometry.size.width * innerRadius, height: pieWidth * geometry.size.width * innerRadius)
                        
                        VStack {
                            Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                                .font(.title)
                                .foregroundColor(self.activeIndex == -1 ? Color.gray : colors[self.activeIndex])
                            Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                                .font(.title)
                        }
                    }
                    
                    PieRows(colors: self.colors, names: self.names, values: self.values.map { self.formatter($0) })
                }
                .background(self.backgroundColor)
                .foregroundColor(Color.white)
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(title: "Expenses", pieItems: [PieItem(name: "Rent", value: 1300, color: .blue), PieItem(name: "Transport", value: 300, color: .red), PieItem(name: "Education", value: 800, color: .green)], formatter: {value in String(format: "$%.2f", value)})
    }
}
