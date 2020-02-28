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

  var transaction: Transaction?
  var onDismiss: (() -> Void)

  var body: some View {
    NavigationView {
      EditorView(transaction: transaction)
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("New Transaction")
        .navigationBarItems(
          leading: Button(action: onDismiss) {
            Text("Cancel")
          },
          trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save").bold()
          }
      )
    }
  }
}

#if DEBUG
struct ComposerView_Previews: PreviewProvider {
  static var previews: some View {
    ComposerView(transaction: Transaction.samples().first!, onDismiss: {})
  }
}
#endif
