//
//  AccountCard.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/19.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AccountCard: View {
  let store: Store<AppState.Overview, AppAction.Overview>

  @State private var flipped: Bool = false

  private let cornerRadius: CGFloat = 20

  lazy var viewStore: ViewStore<AppState.Overview, AppAction.Overview> = ViewStore(store)

  var body: some View {
    WithViewStore(store) { viewStore in
      FlipView(visibleSide: flipped ? .back : .front) {
        Front(store: store, onFlip: { self.flip(true) })
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
        Back(store: store, onFlip: { self.flip(false) })
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
  }

  struct Front: View {
    let store: Store<AppState.Overview, AppAction.Overview>
    let onFlip: () -> Void

    var body: some View {
      WithViewStore(store) { viewStore in
        Card(
          content: {
            ZStack {
              HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                  Button(action: {
                    //self.store.dispatch(.overview(.toggleAccountDetail(presenting: true)))
                  }) {
                    Text(viewStore.account.name)
                      .font(.system(size: 22, weight: .semibold))
                      .foregroundColor(.primary)
                  }

                  Button(action: {

                  }, label: {
                    Image(systemName: "chevron.right")
                      .resizable()
                      .frame(width: 8, height: 8)
                      .foregroundColor(.secondary).padding(.bottom, -1)
                    Text(viewStore.period.display).font(.callout)
                      .foregroundColor(.secondary).padding(.leading, -4)
                  })
                  Spacer()
                }
                Spacer()
              }

              Text(viewStore.amountText)
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
              self.onFlip()
            }) {
              Image(systemName: "info.circle")
                .foregroundColor(.primary)
            }
          })
      }
    }
  }

//  private var front: some View {
//  }

  struct Back: View {
    let store: Store<AppState.Overview, AppAction.Overview>
    let onFlip: () -> Void

    var body: some View {
      WithViewStore(store) { viewStore in
        Card(
          content: {
            VStack {
              Spacer()
              Text(viewStore.account.introduction)
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
          .onTapGesture { self.onFlip() }
      }
    }
  }

//  private var back: some View {
//    Card(
//      content: {
//        VStack {
//          Spacer()
//          Text(account.introduction)
//          Spacer()
//          HStack {
//            Spacer()
//            Text("made with ❤️").font(.footnote)
//          }
//        }
//      },
//      image: {
//        Image(systemName: "dollarsign.circle.fill")
//          .foregroundColor(.primary)
//      })
//      .onTapGesture {
//        self.flip(false)
//      }
//  }

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
