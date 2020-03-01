//
//  TransactionRow.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
  var transaction: Transaction

  var body: some View {
    HStack {
      Text(transaction.catemoji.emoji).font(Font.system(size: 40, weight: .medium))
      VStack(alignment: .leading) {
        Text(transaction.notes).font(.system(size: 20, weight: .medium))
        Text(transaction.date.string).font(.system(size: 14)).foregroundColor(.gray)
      }
      Spacer()
      Text("-\(transaction.currency.symbol)\(String(format: "%.1f", transaction.amount))").font(.system(size: 28, weight: .semibold))
        .foregroundColor(.red)
    }
    .frame(height: 64)
  }
}

#if DEBUG
struct TransactionRow_Previews: PreviewProvider {
  static var previews: some View {
    TransactionRow(transaction: Transaction.samples().first!)
  }
}
#endif
