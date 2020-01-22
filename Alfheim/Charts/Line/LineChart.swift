//
//  LineChart.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/20.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct LineChart: View {
  @ObservedObject var data: UnitData
  var title: String
  var legend: String?

  typealias Value = (rate: Int, specifier: String)
  private var value: Value

  @State private var touchLocation: CGPoint = .zero
  @State private var showsIndicator: Bool = false
  @State private var currentValue: Double = 0

  init(data: [Double], title: String, legend: String? = nil, value: Value) {
    self.data = UnitData(points: data)
    self.title = title
    self.legend = legend
    self.value = value
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        RoundedRectangle(cornerRadius: 20)
          .fill(Color.white)
          .shadow(radius: 8)
        VStack(alignment: .leading) {
          if !self.showsIndicator {
            VStack(alignment: .leading, spacing: 8) {
              Text(self.title).font(.system(size: 24, weight: .semibold)).foregroundColor(.black)
              if self.legend != nil {
                Text(self.legend!).font(.callout).foregroundColor(.gray)
              }
              HStack {
                if self.value.rate >= 0 {
                  Image(systemName: "arrow.up")
                } else {
                  Image(systemName: "arrow.down")
                }
                Text("\(self.value.rate)%")
              }
            }
            .transition(.opacity)
            .animation(.easeIn(duration: 0.1))
            .padding([.leading, .top])
            .frame(width: nil, height: 120, alignment: .center)
          } else {
            HStack {
              Spacer()
              Text("\(self.currentValue, specifier: self.value.specifier)")
                .font(.system(size: 41, weight: .bold, design: .default))
                .offset(x: 0, y: 30)
              Spacer()
            }
            .transition(.scale)
            .frame(width: nil, height: 120, alignment: .center)
          }
          Spacer()
          GeometryReader { geometry in
            Line(data: self.data, frame: .constant(geometry.frame(in: .local)), touchLocation: self.$touchLocation, showsIndicator: self.$showsIndicator)
          }
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .offset(x: 0, y: 0)
          .gesture(DragGesture()
            .onChanged { value in
              self.touchLocation = value.location
              self.showsIndicator = true
              self.handleTouch(to: value.location, in: geometry.frame(in: .local).size)
            }
            .onEnded { value in
              self.showsIndicator = false
            }
          )
        }
      }
    }
  }
}

extension LineChart {
  @discardableResult
  func handleTouch(to point: CGPoint, in frame: CGSize) -> CGPoint {
    let points = self.data.points()

    let stepWidth: CGFloat = frame.width / CGFloat(points.count - 1)
    let stepHeight: CGFloat = (frame.height - 60) / CGFloat(points.max()! - points.min()!)

    let index = Int(round((point.x) / stepWidth))

    if (index >= 0 && index < points.count){
        self.currentValue = points[index]
        return CGPoint(x: CGFloat(index) * stepWidth, y: CGFloat(points[index]) * stepHeight)
    }
    return .zero
  }
}

#if DEBUG
struct LineChart_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LineChart(data: [11, 3, 2, 5, 29, 9], title: "Line chart", legend: "Basic", value: (14, "%.1f"))
        .environment(\.colorScheme, .light)
    }
  }
}
#endif
