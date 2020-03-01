//
//  CatemojiPickerView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/1.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

extension Catemoji: Identifiable {
  var id: String { emoji }
}

struct CatemojiPickerView: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 8) {
        ForEach(Catemoji.allCases) { catemoji in
          HStack(spacing: 8) {
            ForEach(catemoji.allCases) { cate in
              Text(cate.emoji).frame(width: 40, height: 40)
            }
          }
        }
      }
    }
  }
}

#if DEBUG
struct CatemojiPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CatemojiPickerView()
  }
}
#endif
