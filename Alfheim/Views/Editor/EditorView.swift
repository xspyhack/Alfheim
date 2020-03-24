//
//  EditorView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/3.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct EditorView: View {
  @EnvironmentObject var store: AppStore

  private var state: AppState.Editor {
    store.state.editor
  }
  private var binding: Binding<AppState.Editor> {
    $store.state.editor
  }

  enum Mode {
    case new
    case edit
  }

  var body: some View {
    List {
      Section(header: Spacer()) {
        HStack {
          Text("Amount")
          TextField("0.00", text: binding.validator.amount)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing).padding(.trailing, -2.0)
          Text("\(self.state.validator.currency.symbol)")
            .foregroundColor(.gray).opacity(0.8).padding(.trailing, -2.0)
        }
        HStack {
          Picker(selection: binding.validator.currency, label: Text("Currency")) {
            ForEach(Currency.allCases, id: \.self) {
              Text($0.text).tag($0)
            }
          }
        }
      }

      Section {
        DatePicker(selection: binding.validator.date, in: ...Date(), displayedComponents: [.date, .hourAndMinute]) {
          Text("Date")
        }
        HStack {
          CatemojisPicker(selection: binding.validator.emoji, label: Text("Emoji"))
        }
        HStack {
          Text("Notes")
          TextField("", text: binding.validator.notes)
            .lineLimit(nil)
            .multilineTextAlignment(.trailing)
        }
        HStack {
          Picker(selection: binding.validator.payment, label: Text("Payment")) {
            ForEach(Payments.allCases, id: \.self) {
              Text($0.name).tag($0.name)
            }
          }
        }
      }
    }
    .listStyle(GroupedListStyle())
  }
}


#if DEBUG
struct EditorView_Previews: PreviewProvider {
  @State static var notes = ""
  static var previews: some View {
    EditorView().environmentObject(AppStore(moc: viewContext))
  }
}
#endif
