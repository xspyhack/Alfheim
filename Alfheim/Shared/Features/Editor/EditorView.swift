//
//  EditorView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/3.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct EditorView: View {
  let store: Store<AppState.Editor, AppAction.Editor>

  enum Mode {
    case new
    case edit
  }

  var body: some View {
    WithViewStore(self.store) { viewStore in
      List {
        Section(header: Spacer()) {
          HStack {
            Text("Amount")
            TextField(
              "0.00",
              text: viewStore.binding(get: { $0.amount }, send: { AppAction.Editor.changed(.amount($0)) }))
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing).padding(.trailing, -2.0)
            Text("\(viewStore.currency.symbol)")
              .foregroundColor(.gray).opacity(0.8).padding(.trailing, -2.0)
          }
          HStack {
            Picker(
              selection: viewStore.binding(get: { $0.currency }, send: { AppAction.Editor.changed(.currency($0)) }),
              label: Text("Currency")) {
              ForEach(Currency.allCases, id: \.self) {
                Text($0.text).tag($0)
              }
            }
          }
        }

        Section {
          DatePicker(
            selection: viewStore.binding(get: { $0.date }, send: { AppAction.Editor.changed(.date($0)) }),
            in: ...Date(),
            displayedComponents: [.date, .hourAndMinute]
          ) {
            Text("Date")
          }
          HStack {
            CatemojiPicker(
              viewStore.catemojis,
              selection: viewStore.binding(get: { $0.catemoji }, send: { AppAction.Editor.changed(.catemoji($0)) }),
              label: Text("Emoji")
            )
          }
          HStack {
            Text("Notes")
            InputTextField(
              "Notes",
              text: viewStore.binding(get: { $0.notes }, send: { AppAction.Editor.changed(.notes($0)) }),
              isFirstResponder: .constant(false)
            )
            .multilineTextAlignment(.trailing)
          }
          HStack {
            Picker(
              selection: viewStore.binding(get: { $0.payment }, send: { AppAction.Editor.changed(.payment($0)) }),
              label: Text("Payment")
            ) {
              ForEach(0..<viewStore.payments.count) { payment in
                HStack(alignment: .center, spacing: 2) {
                  Text(viewStore.payments[payment].fullname)
                  //Text(" - \(payment.kind.fullname)")
                }
              }
            }
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
    }
  }
}


//#if DEBUG
//struct EditorView_Previews: PreviewProvider {
//  @State static var notes = ""
//  static var previews: some View {
//    EditorView().environmentObject(AppStore(moc: viewContext))
//  }
//}
//#endif
