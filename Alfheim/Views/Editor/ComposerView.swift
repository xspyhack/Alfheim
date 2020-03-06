//
//  ComposerView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct ComposerView: View {
  // alternative dismiss
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var store: AppStore

  private var state: AppState.Editor {
    store.state.editor
  }

  var transaction: Alne.Transaction?
  var onDismiss: (() -> Void)

  var body: some View {
    NavigationView {
      EditorView(mode: transaction.map { .edit($0) } ?? .new)
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarItems(
          leading: Button(action: onDismiss) {
            Text("Cancel")
          },
          trailing: Button(action: {
            self.store.dispatch(.editors(.save(self.state.validator.transaction)))
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save").bold()
          }
          .disabled(!state.isValid)
        )
    }
  }
}

#if DEBUG
struct ComposerView_Previews: PreviewProvider {
  static var previews: some View {
    ComposerView(transaction: Alne.Transactions.samples().first!, onDismiss: {})
  }
}
#endif
