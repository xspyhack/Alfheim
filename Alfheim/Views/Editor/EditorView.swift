//
//  EditorView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/3.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct EditorView: View {
  // @Environment(\.presentationMode) var presentationMode
  var transaction: Transaction?

  @State var amount: String = ""
  @State var selectedEmoji = 0
  @State var selectedCurrency = 0
  @State var selectedDate = Date()
  @State var notes: String = ""

  var currencies = Currency.allCases
  var emojis = ["🍟", "🍇", "🍎"]

  var body: some View {
    List {
      Section(header: Spacer()) {
        HStack {
          Text("Amount")
          TextField("0.00", text: $amount)
            .multilineTextAlignment(.trailing).padding(.trailing, -2.0)
          Text("\(self.currencies[selectedCurrency].symbol)")
            .foregroundColor(.gray).opacity(0.8).padding(.trailing, -2.0)
        }
        HStack {
          Picker(selection: $selectedCurrency, label: Text("Currency")) {
            ForEach(0..<currencies.count) {
              Text(self.currencies[$0].text)
            }
          }
        }
      }

      Section {
        DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
          Text("Date")
        }
        HStack {
          Picker(selection: $selectedEmoji, label: Text("Emoji")) {
            ForEach(0..<emojis.count) {
              Text(self.emojis[$0])
            }
          }
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
    EditorView(transaction: Transaction.samples().first!)
  }
}
#endif
