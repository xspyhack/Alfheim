//
//  TransactionList.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/5.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
  var body: some View {
    ForEach(0..<10) { i in
      TransactionRow()
    }
  }
}

struct TransactionList_Previews: PreviewProvider {
  static var previews: some View {
    TransactionList()
  }
}
