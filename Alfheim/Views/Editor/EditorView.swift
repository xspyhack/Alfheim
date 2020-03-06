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
    case edit(Alne.Transaction)
  }

  var mode: Mode
  @State var amount: String
  @State var selectedCurrency: Alne.Currency
  @State var selectedEmoji: Alne.Catemoji
  @State var selectedDate: Date
  @State var notes: String
  @State var payment: String

  init(mode: Mode) {
    switch mode {
    case .new:
      self._notes = State(initialValue: "")
      self._amount = State(initialValue: "")
      self._selectedDate = State(initialValue: Date())
      self._selectedCurrency = State(initialValue: .cny)
      self._selectedEmoji = State(initialValue: Alne.Catemoji.fruit(.apple))
      self._payment = State(initialValue: "Pay")
    case .edit(let transaction):
      self._notes = State(initialValue: transaction.notes)
      self._amount = State(initialValue: "\(transaction.amount)")
      self._selectedDate = State(initialValue: transaction.date)
      self._selectedCurrency = State(initialValue: transaction.currency)
      self._selectedEmoji = State(initialValue: transaction.catemoji)
      self._payment = State(initialValue: transaction.payment ?? "Pay")
    }
    self.mode = mode
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
            ForEach(Alne.Currency.allCases, id: \.self) {
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
          CatemojiPicker(selection: binding.validator.emoji, label: Text("Emoji"))
        }
        HStack {
          Text("Payment")
          TextField("", text: binding.validator.payment)
            .foregroundColor(.gray).opacity(0.8)
            .multilineTextAlignment(.trailing)
        }
        HStack {
          Text("Notes")
          TextField("", text: binding.validator.notes)
            .lineLimit(nil)
            .multilineTextAlignment(.trailing)
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
    EditorView(mode: .new)
  }
}
#endif
