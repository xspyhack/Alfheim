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

  let mode: EditorView.Mode

  var body: some View {
    NavigationView {
      EditorView()
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("New Transaction")
        .navigationBarItems(
          leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }) {
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
    ComposerView(mode: .new)
  }
}
#endif
