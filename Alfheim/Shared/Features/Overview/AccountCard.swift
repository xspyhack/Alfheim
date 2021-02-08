//
//  AccountCard.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/19.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct AccountCard: View {
  @EnvironmentObject var store: Store<AppState.Overview, AppAction.Overview>
  @State private var flipped: Bool = false

  private let cornerRadius: CGFloat = 20

  private var account: Alfheim.Account {
    store.state.account
  }

  private var state: AppState.Overview {
    store.state
  }

  var body: some View {
    FlipView(visibleSide: flipped ? .back : .front) {
      front
        .background(
          RoundedRectangle(cornerRadius: cornerRadius)
          .fill(LinearGradient(
            gradient: Gradient(colors: [Color("AH03"), Color("Blue60")]),
            startPoint: .top,
            endPoint: .bottom
          ))
          .shadow(radius: 8)
        )
    } back: {
      back
        .background(
          RoundedRectangle(cornerRadius: cornerRadius)
          .fill(LinearGradient(
            gradient: Gradient(colors: [Color("AH03"), Color("Blue60")]),
            startPoint: .top,
            endPoint: .bottom
          ))
          .shadow(radius: 8)
        )
    }
    .animation(Animation.spring(response: 0.35, dampingFraction: 0.7), value: flipped)
  }

  private var front: some View {
    Card(
      content: {
        ZStack {
          HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
              Button(action: {
                //self.store.dispatch(.overview(.toggleAccountDetail(presenting: true)))
              }) {
                Text(account.name)
                  .font(.system(size: 22, weight: .semibold))
                  .foregroundColor(.primary)
              }

              Button(action: {

              }, label: {
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 8, height: 8)
                  .foregroundColor(.secondary).padding(.bottom, -1)
                Text(state.period.display).font(.callout)
                  .foregroundColor(.secondary).padding(.leading, -4)
              })
              Spacer()
            }
            Spacer()
          }

          Text(state.amountText)
            .gradient(LinearGradient(
              gradient: Gradient(colors: [.pink, .purple]),
              startPoint: .leading,
              endPoint: .trailing
            ))
            .font(.system(size: 36, weight: .semibold))
            .padding(.top, 2.0)
        }

      },
      image: {
        Button(action: {
          self.flip(true)
        }) {
          Image(systemName: "info.circle")
            .foregroundColor(.primary)
        }
      })
  }

  private var back: some View {
    Card(
      content: {
        VStack {
          Spacer()
          Text(account.introduction)
          Spacer()
          HStack {
            Spacer()
            Text("made with ❤️").font(.footnote)
          }
        }
      },
      image: {
        Image(systemName: "dollarsign.circle.fill")
          .foregroundColor(.primary)
      })
      .onTapGesture {
        self.flip(false)
      }
  }

  private func flip(_ flag: Bool) {
    withAnimation(.easeOut(duration: 0.35)) {
      self.flipped = flag
    }
  }

  private struct Card<Content: View, Image: View>: View {
    private let cornerRadius: CGFloat = 20

    private let content: Content
    private let image: Image

    init(@ViewBuilder content: () -> Content, @ViewBuilder image: () -> Image) {
      self.content = content()
      self.image = image()
    }

    var body: some View {
      ZStack(alignment: .topTrailing) {
        ZStack {
          RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(
              gradient: Gradient(colors: [Color("AH03"), Color("Blue60")]),
              startPoint: .top,
              endPoint: .bottom
            ))
            .cornerRadius(cornerRadius)

          content
            .padding()
        }

        image
          .padding(.top, 5)
          .padding()
      }
    }
  }
}

//#if DEBUG
//struct AccountCard_Previews: PreviewProvider {
//  static var previews: some View {
//    AccountCard()
//      .environment(\.colorScheme, .dark)
//      .environmentObject(AppStore(moc: viewContext))
//  }
//}
//#endif
