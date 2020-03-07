//
//  CatemojiPicker.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

extension Catemoji: Identifiable {
  var id: String { emoji }
}

struct CatemojiPicker<Label>: View where Label: View {
  let numbersPerRow = 6
  let catemojis = Catemoji.allCases

  private var numberOfRows: Int {
    if catemojis.count % numbersPerRow == 0 {
      return catemojis.count / numbersPerRow
    } else {
      return catemojis.count / numbersPerRow + 1
    }
  }

  @State var isContentActive: Bool = false

  let selection: Binding<Catemoji>
  let label: Label

  init(selection: Binding<Catemoji>, label: Label) {
    self.selection = selection
    self.label = label
  }
  
  var body: some View {
    NavigationLink(destination: content, isActive: $isContentActive) {
      HStack {
        label
        Spacer()
        Text(selection.wrappedValue.emoji)
      }
    }
  }

  var content: some View {
    Group {
      GeometryReader { proxy in
        VStack(alignment: .leading, spacing: 0) {
          ForEach(0..<self.numberOfRows) { row in
            HStack(spacing: 0) {
              ForEach(self.items(at: row)) { catemoji in
                Button(action: {
                  self.selection.wrappedValue = catemoji
                  self.isContentActive = false
                }) {
                  Text(catemoji.emoji).font(Font.system(size: 28))
                }
                .frame(width: self.itemWidth(in: proxy), height: self.itemWidth(in: proxy))
              }
            }
          }
          Spacer()
        }
      }
      .navigationBarTitle("Emoji")
      .padding()
    }
  }

  private func items(at row: Int) -> [Catemoji] {
    if row < numberOfRows - 1 {
      return Array(Catemoji.allCases[numbersPerRow * row ..< numbersPerRow * row + numbersPerRow])
    } else if row == numberOfRows - 1 {
      return Array(Catemoji.allCases[numbersPerRow * row ..< numbersPerRow * row + catemojis.count % numbersPerRow])
    } else {
      fatalError("row out of bounds")
    }
  }

  private func itemWidth(in geo: GeometryProxy) -> CGFloat {
    geo.size.width / CGFloat(numbersPerRow)
  }
}

#if DEBUG
struct CatemojiPicker_Previews: PreviewProvider {
  static var previews: some View {
    CatemojiPicker(selection: .constant(.food(.eating)), label: Text(""))
//      .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
  }
}
#endif
