//
//  ComposerView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ComposerView: View {
  // alternative dismiss
  @Environment(\.presentationMode) var presentationMode
  let store: Store<AppState.Editor, AppAction.Editor>

  let mode: EditorView.Mode

  var body: some View {
    NavigationView {
      WithViewStore(store) { viewStore in
        EditorView(store: store)
          .navigationBarTitle(viewStore.isNew ? " New Transaction" : "Edit Transaction")
          .navigationBarItems(
            leading: Button(action: {
              self.presentationMode.wrappedValue.dismiss()
            }) {
              Text("Cancel")
            },
            trailing: Button(action: {
              let action = AppAction.Editor.save(viewStore.transaction, mode: viewStore.isNew ? .new : .update)
              viewStore.send(action)
              self.presentationMode.wrappedValue.dismiss()
            }) {
              Text("Save").bold()
            }
            .disabled(!viewStore.isValid)
          )
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

#if DEBUG
//struct ComposerView_Previews: PreviewProvider {
//  static var previews: some View {
//    ComposerView(mode: .new)
//  }
//}
#endif
