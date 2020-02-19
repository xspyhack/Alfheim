//
//  TransactionsView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
  var body: some View {
    ForEach(Transaction.samples()) { transaction in
      TransactionRow(transaction: transaction)
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
