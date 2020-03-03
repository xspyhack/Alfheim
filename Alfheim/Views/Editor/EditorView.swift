//
//  EditorView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/3.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct EditorView: View {
  enum Mode {
    case new
    case edit(Alne.Transaction?)
  }
  var transaction: Alne.Transaction?

  @State var amount: String
  @State var selectedCurrency: Alne.Currency
  @State var selectedEmoji: Alne.Catemoji
  @State var selectedDate: Date
  @State var notes: String

  init(transaction: Alne.Transaction?) {
    self.transaction = transaction
    self._notes = .init(initialValue: transaction?.notes ?? "")
    self._amount = State(initialValue: transaction != nil ? "\(transaction!.amount)" : "")
    self._selectedDate = State(initialValue: transaction?.date ?? Date())
    self._selectedCurrency = .init(initialValue: transaction?.currency ?? .cny)
    self._selectedEmoji = .init(initialValue: transaction?.catemoji ?? Alne.Catemoji.fruit(.apple))
  }

  var body: some View {
    List {
      Section(header: Spacer()) {
        HStack {
          Text("Amount")
          TextField("0.00", text: $amount)
            .multilineTextAlignment(.trailing).padding(.trailing, -2.0)
          Text("\(self.selectedCurrency.symbol)")
            .foregroundColor(.gray).opacity(0.8).padding(.trailing, -2.0)
        }
        HStack {
          Picker(selection: $selectedCurrency, label: Text("Currency")) {
            ForEach(Alne.Currency.allCases, id: \.self) {
              Text($0.text).tag($0)
            }
          }
        }
      }

      Section {
        DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
          Text("Date")
        }
        HStack {
          CatemojiPicker(selection: $selectedEmoji, label: Text("Emoji"))
        }
        HStack {
          Text("Notes")
          TextField(transaction?.notes ?? "", text: $notes)
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
    EditorView(transaction: Alne.Transactions.samples().first!)
  }
}
#endif
