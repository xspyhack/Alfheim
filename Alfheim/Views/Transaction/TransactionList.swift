//
//  TransactionList.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/5.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
  @State private var transaction: Alne.Transaction?

  var body: some View {
    List {
      ForEach(Alne.Transactions.samples()) { transaction in
        TransactionRow(transaction: transaction)
          .onTapGesture {
            self.transaction = transaction
        }
      }
    }
    .navigationBarTitle("Transactions")
    .sheet(item: $transaction) { transaction in
      ComposerView(transaction: transaction) {}
    }
  }
}

#if DEBUG
struct TransactionList_Previews: PreviewProvider {
  static var previews: some View {
    TransactionList()
  }
}
#endif
