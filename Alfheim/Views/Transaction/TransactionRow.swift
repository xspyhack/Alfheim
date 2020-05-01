//
//  TransactionRow.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
  var model: TransactionViewModel

  var body: some View {
    HStack {
      Text(model.catemoji.emoji)
        .font(Font.system(size: 40, weight: .medium))
        .frame(width: 48, height: 48)
      VStack(alignment: .leading) {
        Text(model.notes).font(.system(size: 20, weight: .medium))
        Text(model.date.string)
          .font(.system(size: 14))
          .foregroundColor(.gray)
          .lineLimit(1)
      }
      Spacer()
      Text("-\(model.currency.symbol)\(String(format: "%.1f", model.amount))")
        .font(.system(size: 28, weight: .semibold))
        .foregroundColor(Color(tagit: model.tag))
    }
    .frame(height: 64)
  }
}

#if DEBUG
struct TransactionRow_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      TransactionRow(model: TransactionViewModel.mock)
    }.padding()
  }
}
#endif
