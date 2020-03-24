//
//  CatemojiPicker.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/23.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct CatemojiPicker: View {
  var body: some View {
    VStack {
      HStack {
        Text("Food")
        Text("Drink")
      }

      List {
        ForEach(0..<10) { _ in
          Text("Row")
        }
      }
    }
  }
}

#if DEBUG
struct CatemojiPicker_Previews: PreviewProvider {
  static var previews: some View {
    CatemojiPicker()
  }
}
#endif
