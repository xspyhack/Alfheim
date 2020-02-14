//
//  TransactionRow.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
  var body: some View {
    HStack {
      Text("Transaction")
      Spacer()
    }
    .frame(height: 40)
  }
}

struct TransactionRow_Previews: PreviewProvider {
  static var previews: some View {
    TransactionRow()
  }
}
