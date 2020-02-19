//
//  TransactionList.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/5.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
  @State private var transaction: Transaction?

  var body: some View {
    List {
      ForEach(Transaction.samples()) { transaction in
        TransactionRow(transaction: transaction)
          .onTapGesture {
            self.transaction = transaction
        }
      }
    }
    .navigationBarTitle("Transactions")
    .sheet(item: $transaction) { transaction in
      EditorView(transaction: transaction)
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
