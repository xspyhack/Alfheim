//
//  TransactionsView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
  @State private var transaction: Transaction?

  var body: some View {
    List {
      TransactionList()
    }
    .navigationBarTitle("Transactions")
    .sheet(item: $transaction) { transaction in
      EditorView(transaction: transaction)
    }
  }
}

#if DEBUG
struct TransactionsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TransactionsView()
    }
  }
}
#endif
