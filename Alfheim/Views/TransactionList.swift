//
//  TransactionList.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/5.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
  @State private var showEditor: Bool = false
  @State private var transaction: Transaction?

  var body: some View {
    ForEach(Transaction.samples()) { transaction in
      TransactionRow(transaction: transaction)
        .onTapGesture {
          self.transaction = transaction
          self.showEditor.toggle()
          print("tap")
      }
    }
//    .sheet(isPresented: $showEditor) {
//      EditorView(transaction: self.transaction)
//    }
  }
}

#if DEBUG
struct TransactionList_Previews: PreviewProvider {
  static var previews: some View {
    TransactionList()
  }
}
#endif
