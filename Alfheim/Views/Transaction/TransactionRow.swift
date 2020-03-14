//
//  TransactionRow.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
  var transaction: Alne.Transaction

  var body: some View {
    HStack {
      Text(transaction.catemoji.emoji)
        .font(Font.system(size: 40, weight: .medium))
        .frame(width: 48, height: 48)
      VStack(alignment: .leading) {
        Text(transaction.notes).font(.system(size: 20, weight: .medium))
        Text(transaction.date.string)
          .font(.system(size: 14))
          .foregroundColor(.gray)
          .lineLimit(1)
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
    ScrollView {
      TransactionRow(transaction: Alne.Transactions.samples()[0])
      TransactionRow(transaction: Alne.Transactions.samples().last!)
    }.padding()
  }
}
#endif
