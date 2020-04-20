//
//  PaymentList.swift
//  Alfheim
//
//  Created by alex.huo on 2020/4/20.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct PaymentList: View {
  @EnvironmentObject var store: AppStore

  private var state: AppState.Payment {
    store.state.payment
  }

  private var binding: Binding<AppState.Payment> {
    $store.state.payment
  }

  private var tag: Tagit {
    store.state.shared.account.tag
  }

  var body: some View {
    List {
      ForEach(state.displayViewModels(tag: self.tag)) { viewModel in
        PaymentRow(model: viewModel)
          .onTapGesture {
            //self.store.dispatch(.transactions(.editTransaction(viewModel.transaction)))
        }
      }
      .onDelete { indexSet in
        self.store.dispatch(.transactions(.delete(at: indexSet)))
      }
    }
    .navigationBarTitle("Payments")
  }
}

#if DEBUG
struct PaymentList_Previews: PreviewProvider {
  static var previews: some View {
    PaymentList()
  }
}
#endif
