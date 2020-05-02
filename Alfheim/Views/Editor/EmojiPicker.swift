//
//  EmojiPicker.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct EmojiPicker<Label>: View where Label: View {
  let numbersPerRow = 6
  let emojis: [Emoji] = [""]

  typealias Emoji = String

  private var numberOfRows: Int {
    if emojis.count % numbersPerRow == 0 {
      return emojis.count / numbersPerRow
    } else {
      return emojis.count / numbersPerRow + 1
    }
  }

  @State var isContentActive: Bool = false

  let selection: Binding<Emoji>
  let label: Label

  init(selection: Binding<Emoji>, label: Label) {
    self.selection = selection
    self.label = label
  }
  
  var body: some View {
    NavigationLink(destination: content, isActive: $isContentActive) {
      HStack {
        label
        Spacer()
        Text(selection.wrappedValue)
      }
    }
  }

  var content: some View {
    Group {
      GeometryReader { proxy in
        VStack(alignment: .leading, spacing: 0) {
          ForEach(0..<self.numberOfRows) { row in
            HStack(spacing: 0) {
              ForEach(self.items(at: row), id: \.self) { emoji in
                Button(action: {
                  self.selection.wrappedValue = emoji
                  self.isContentActive = false
                }) {
                  Text(emoji).font(Font.system(size: 28))
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

  private func items(at row: Int) -> [Emoji] {
    if row < numberOfRows - 1 || emojis.count % numbersPerRow == 0 {
      return Array(emojis[numbersPerRow * row ..< numbersPerRow * row + numbersPerRow])
    } else if row == numberOfRows - 1 {
      return Array(emojis[numbersPerRow * row ..< numbersPerRow * row + emojis.count % numbersPerRow])
    } else {
      fatalError("row out of bounds")
    }
  }

  private func itemWidth(in geo: GeometryProxy) -> CGFloat {
    geo.size.width / CGFloat(numbersPerRow)
  }
}

#if DEBUG
struct CatemojisPicker_Previews: PreviewProvider {
  static var previews: some View {
    EmojiPicker(selection: .constant(""), label: Text(""))
//      .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
  }
}
#endif
