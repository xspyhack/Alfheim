//
//  AccountCard.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/19.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct AccountCard: View {
  @EnvironmentObject var store: AppStore

  private var state: AppState.Shared {
    store.state.shared
  }

  private var binding: Binding<AppState.Overview> {
    $store.state.overview
  }

  @State private var flipped: Bool = false
  private let cornerRadius: CGFloat = 20

  var body: some View {
    ZStack {
      frontSide().opacity(flipped ? 0 : 1)
      backSide().opacity(flipped ? 1 : 0)
    }
    .background(
      RoundedRectangle(cornerRadius: cornerRadius)
        .fill(LinearGradient(
          gradient: Gradient(colors: [Color("Pink40"), Color("Violet40")]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        ))
        .shadow(radius: 8)
    ).rotation3DEffect(.degrees(flipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))
  }

  private func frontSide() -> some View {
    ZStack {
      VStack {
        HStack(alignment: .top) {
          VStack(alignment: .leading, spacing: 6) {
            Button(action: {
              self.store.dispatch(.overview(.toggleAccountDetail(presenting: true)))
            }) {
              Text(state.account.name)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.primary)
            }
            .sheet(isPresented: binding.isAccountDetailPresented) {
              AccountDetail() {
                self.store.dispatch(.overview(.toggleAccountDetail(presenting: false)))
              }
              .environmentObject(self.store)
            }

            Button(action: {
              self.store.dispatch(.overview(.switchPeriod))
            }) {
              Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 8)
                .foregroundColor(.secondary).padding(.bottom, -1)
              Text(state.period.display).font(.callout)
                .foregroundColor(.secondary).padding(.leading, -4)
            }
          }
          Spacer()
          Button(action: {
            self.flip(true)
          }) {
            Image(systemName: "info.circle")
              .foregroundColor(.primary)
              .padding(.top, 5)
          }
        }
        Spacer()
      }
      .padding([.leading, .top, .trailing])

      Text(state.amountText)
        .gradient(LinearGradient(
          gradient: Gradient(colors: [.pink, .purple]),
          startPoint: .leading,
          endPoint: .trailing
        ))
        .font(.system(size: 36, weight: .semibold))
        .padding(.top, 2.0)
    }
  }

  private func backSide() -> some View {
    ZStack(alignment: .topTrailing) {
      ZStack {
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(LinearGradient(
            gradient: Gradient(colors: [Color("Violet40"), Color("Pink40")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          ))
          .cornerRadius(cornerRadius)
          .onTapGesture {
            self.flip(false)
        }
        VStack {
          Spacer()
          Text(state.account.description)
          Spacer()
          HStack {
            Spacer()
            Text("made with ❤️").font(.footnote)
          }
        }
        .padding()
      }

      Image(systemName: "dollarsign.circle.fill")
        .foregroundColor(.primary)
        .padding(.top, 5)
        .padding()
    }
    .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
  }

  private func flip(_ flag: Bool) {
    withAnimation(.easeOut(duration: 0.35)) {
      self.flipped = flag
    }
  }
}

#if DEBUG
struct AccountCard_Previews: PreviewProvider {
  static var previews: some View {
    AccountCard()
      .environment(\.colorScheme, .dark)
      .environmentObject(AppStore(moc: viewContext))
  }
}
#endif
