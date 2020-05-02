//
//  CatemojiView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/5/2.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct CatemojiView: View {
  @State var selectedCategory: Category = .drink

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          ForEach(Category.allCases, id: \.self) { category in
            ZStack {
              if self.selectedCategory == category {
                Circle().foregroundColor(Color.gray).opacity(0.2)
              }
              Text(category.text).font(.system(size: 28))
            }
            .contentShape(Rectangle())
            .onTapGesture {
              self.selectedCategory = category
            }
            .frame(width: 44, height: 44)
          }
        }
        .padding(.leading, 10)
        .padding(.trailing, 16)
      }

      HStack {
        Text(selectedCategory.name.uppercased())
          .bold()

        Spacer()

        Button(action: {
        }) {
          Image(systemName: "plus")
        }
      }
      .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))

      Grid(self.emojis(in: selectedCategory), id: \.self) {
        Text($0)
      }
      .gridStyle(columns: 6)
    }
  }

  private func emojis(in category: Category) -> [String] {
    switch category {
    case .food:
      return Alne.Food.allCases.map { $0.emoji }
    case .drink:
      return Alne.Drink.allCases.map { $0.emoji }
    case .fruit:
      return Alne.Fruit.allCases.map { $0.emoji }
    case .clothes:
      return Alne.Clothes.allCases.map { $0.emoji }
    case .household:
      return Alne.Household.allCases.map { $0.emoji }
    case .personal:
      return Alne.Personal.allCases.map { $0.emoji }
    case .transportation:
      return Alne.Transportation.allCases.map { $0.emoji }
    case .services:
      return ["Services"]
    case .uncleared:
      return ["Uncleared"]
    }
  }
}

#if DEBUG
struct CatemojiView_Previews: PreviewProvider {
  static var previews: some View {
    CatemojiView()
  }
}
#endif
