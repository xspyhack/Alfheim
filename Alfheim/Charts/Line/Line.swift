//
//  Line.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/20.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct Line: View {
  @ObservedObject var data: UnitData
  @Binding var frame: CGRect
  @Binding var touchLocation: CGPoint
  @Binding var showsIndicator: Bool
  @State private var fill: Bool = false
  @State var showsBackground: Bool = true
  @State var padding: CGFloat = 20

  var stepWidth: CGFloat {
    if data.units.count < 2 {
      return 0
    }
    return frame.size.width / CGFloat(data.units.count - 1)
  }

  var stepHeight: CGFloat {
    let points = data.points()

    guard let min = points.min(),
      let max = points.max(), min != max else {
      return 0
    }
    return (frame.size.height - padding * 2) / CGFloat(max - min)
  }

  var step: CGPoint {
    CGPoint(x: stepWidth, y: stepHeight)
  }

  var path: Path {
    let points = data.points()
    return Path.quadCurved(points: points,
                           step: step,
                           padding: padding)
  }

  var closedPath: Path {
    let points = data.points()
    return Path.quadCurved(points: points,
                           step: step,
                           padding: padding,
                           closed: true)
  }

  var body: some View {
    ZStack {
      if fill && showsBackground {
        closedPath
          .fill(LinearGradient(gradient: Gradient(colors: [.ah01, .white]), startPoint: .bottom, endPoint: .top))
          .rotationEffect(.degrees(180), anchor: .center)
          .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
          .transition(.opacity)
          .animation(.easeIn(duration: 1.6))
      }
      path.trim(from: 0, to: fill ? 1 : 0)
        .stroke(LinearGradient(gradient: Gradient(colors: [.ah02, .ah03]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 3))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        .animation(.easeOut(duration: 1.2))
        .onAppear() {
          self.fill.toggle()
        }
        .drawingGroup()
      if showsIndicator {
        Indicator()
          .position(closestPoint(point: touchLocation))
          .rotationEffect(.degrees(180), anchor: .center)
          .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
      }
    }
  }
}

extension Line {
  func closestPoint(point: CGPoint) -> CGPoint {
    return path.point(to: point.x)
  }
}

extension Color {
  static let ah01 = Color("AH01")
  static let ah02 = Color("AH02")
  static let ah03 = Color("AH03")
}


#if DEBUG
struct Line_Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      Line(data: UnitData(points: [20, 6, 4, 2, 4, 6, 0]), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 10, y: 12)), showsIndicator: .constant(true))
    }
    .frame(width: 320, height: 460)
  }
}
#endif
